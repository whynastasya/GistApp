//
//  GistsListViewController.swift
//  GistApp
//
//  Created by nastasya on 26.09.2024.
//

import UIKit
import Combine

final class GistsListViewController<ViewModel: ObservableViewModel>:
    UIViewController, UITableViewDataSource, UITableViewDelegate
    where ViewModel.State == GistsListState, ViewModel.Action == GistsListAction {
    
    private var viewModel: ViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    private let gistsListView = GistsListView()
    private let errorView = ErrorView()
    private let loadingView = LoadingView()
    private let refreshControl = UIRefreshControl()
    
    private var gists: [GistMainInformation] = []
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupGistsListView()
        subscribeToState()
        setupNavigationBar()
        viewModel.handle(.viewDidLoad)
    }
    
    private func subscribeToState() {
        viewModel.subscribe { [weak self] newState in
            self?.handleNewState(newState)
        }
        .store(in: &cancellables)
    }
    
    private func handleNewState(_ state: GistsListState) {
        loadingView.removeFromSuperview()
        errorView.removeFromSuperview()
        gistsListView.removeFromSuperview()
        
        switch state.status {
            case .loading:
                self.gists = []
                view.addSubview(loadingView)
                loadingView.frame = view.bounds
            case .loaded(let gists):
                self.gists = gists
                view.addSubview(gistsListView)
                gistsListView.frame = view.bounds
                stopRefreshing()
                gistsListView.tableView.reloadData()
            case .error:
                self.gists = []
                view.addSubview(errorView)
                errorView.frame = view.bounds
                errorView.retryAction = { [weak viewModel] in
                    viewModel?.handle(.didTappedRestartButton)
                }
        }
    }
    
    private func setupGistsListView() {
        gistsListView.tableView.dataSource = self
        gistsListView.tableView.delegate = self
        
        gistsListView.tableView.rowHeight = UITableView.automaticDimension
        gistsListView.tableView.estimatedRowHeight = 100
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        gistsListView.tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshData() {
        viewModel.handle(.refresh)
    }
    
    private func stopRefreshing() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.gistsListView.tableView.reloadData()
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Gists"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //Данные методы должны быть в extensions, но из-за использования дженерика в инстансе что-то не получается, не смогла пофиксить
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GistMainInformationTableViewCell.identifier,
            for: indexPath) as? GistMainInformationTableViewCell else { return UITableViewCell() }
        
        let gist = gists[indexPath.row]
        cell.configure(with: gist)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGistId = gists[indexPath.item].id
        viewModel.handle(.didSelectGist(id: selectedGistId))
    }
}
