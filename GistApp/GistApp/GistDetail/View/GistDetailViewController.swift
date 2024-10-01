//
//  GistDetailViewController.swift
//  GistApp
//
//  Created by nastasya on 26.09.2024.
//

import UIKit
import Combine

final class GistDetailViewController<ViewModel: ObservableViewModel>:
    UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
where ViewModel.State == GistDetailState, ViewModel.Action == GistDetailAction {
    
    private var viewModel: ViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    private let gistDetailView = GistDetailView()
    private let errorView = ErrorView()
    private let loadingView = LoadingView()
    private let refreshControl = UIRefreshControl()
    
    private var gist: Gist?
    
    private enum SectionType: Int {
        case info = 0
        case files
        case commits
    }
    
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
        setupGistDetailView()
        subscribeToState()
        viewModel.handle(.viewDidLoad)
    }
    
    private func subscribeToState() {
        viewModel.subscribe { [weak self] newState in
            self?.handleNewState(newState)
        }
        .store(in: &cancellables)
    }
    
    private func handleNewState(_ state: GistDetailState) {
        loadingView.removeFromSuperview()
        errorView.removeFromSuperview()
        gistDetailView.removeFromSuperview()
        
        switch state.status {
            case .loading:
                self.gist = nil
                view.addSubview(loadingView)
                loadingView.frame = view.bounds
            case .loaded(let gist):
                self.gist = gist
                view.addSubview(gistDetailView)
                gistDetailView.frame = CGRect(origin: CGPoint(x: view.bounds.minX, y: view.bounds.minY + 20), size: view.bounds.size)
                gistDetailView.collectionView.reloadData()
                stopRefreshing()
            case .error:
                self.gist = nil
                view.addSubview(errorView)
                errorView.frame = view.bounds
                stopRefreshing()
        }
    }
    
    private func setupGistDetailView() {
        gistDetailView.collectionView.delegate = self
        gistDetailView.collectionView.dataSource = self
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        gistDetailView.collectionView.refreshControl = refreshControl
    }
            
    @objc private func refreshData() {
        viewModel.handle(.refresh)
    }
            
    private func stopRefreshing() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    //Данные методы должны быть в extensions, но из-за использования дженерика в инстансе что-то не получается, не смогла пофиксить
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let gist = gist else { return 0 }
        
        let sectionType = SectionType(rawValue: section)
        switch sectionType {
            case .info:
                return 1
            case .files:
                return gist.filesNames.count
            case .commits:
                return gist.commits?.count ?? 0
            case .none:
                return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let gist = gist else {
            return UICollectionViewCell()
        }
        
        let sectionType = SectionType(rawValue: indexPath.section)
        
        switch sectionType {
            case .info:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: GistMainInformationCollectionViewCell.identifier,
                    for: indexPath) as? GistMainInformationCollectionViewCell else { return UICollectionViewCell(
                    ) }
                let mainInformation = GistMainInformation(id: gist.id, name: gist.name, author: gist.author)
                cell.configure(with: mainInformation)
                return cell
            case .files:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: GistFilesInformationCollectionViewCell.identifier,
                    for: indexPath) as? GistFilesInformationCollectionViewCell else { return UICollectionViewCell(
                    ) }
                let fileName = "\(indexPath.row + 1). " + gist.filesNames[indexPath.item]
                cell.configure(with: fileName)
                return cell
            case .commits:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: GistCommitsInformationCollectionViewCell.identifier,
                    for: indexPath) as? GistCommitsInformationCollectionViewCell else { return UICollectionViewCell(
                    ) }
                if let commit = gist.commits?[indexPath.item] {
                    cell.configure(with: commit)
                }
                return cell
            case .none:
                return UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width
        let sectionType = SectionType(rawValue: indexPath.section)
        var height: CGFloat
        
        switch sectionType {
            case .info:
                height = 100
            case .files, .commits:
                height = 40
            case .none:
                height = 0
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderCollectionReusableView.identifier,
                for: indexPath
            ) as? HeaderCollectionReusableView else { return UICollectionReusableView() }
            
            let sectionType = SectionType(rawValue: indexPath.section)
            switch sectionType {
                case .info:
                    header.configure(with: "")
                case .files:
                    header.configure(with: "Files")
                case .commits:
                    header.configure(with: "Commits")
                case .none:
                    header.configure(with: "")
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}

