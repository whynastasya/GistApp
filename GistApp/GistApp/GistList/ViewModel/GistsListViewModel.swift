//
//  GistsListViewController.swift
//  GistApp
//
//  Created by nastasya on 26.09.2024.
//

import Foundation

final class GistsListViewModel: ObservableViewModel {
    @Published var state: GistsListState
    weak var coordinatorDelegate: IGistsListCoordinator?
    private var networkService: INetworkService
    
    init(state: GistsListState = GistsListState(status: .loading), networkService: INetworkService) {
        self.state = state
        self.networkService = networkService
    }

    func handle(_ action: GistsListAction) {
        switch action {
            case .didSelectGist(let id):
                coordinatorDelegate?.didSelectGist(with: id)
            case .viewDidLoad, .didTappedRestartButton:
                fetchGists()
            case .refresh:
                reloadGists()
        }
    }
    
    private func fetchGists() {
        state.status = .loading
        
        networkService.fetchGists { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let gists):
                    let mainInformation = gists.map { gist in
                        GistMainInformation(id: gist.id, name: gist.name, author: gist.author)
                    }
                    DispatchQueue.main.async {
                        self.state.status = .loaded(mainInformation)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.state.status = .error
                    }
            }
        }
    }
    
    private func reloadGists() {
        networkService.fetchGists { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let gists):
                    let mainInformation = gists.map { gist in
                        GistMainInformation(id: gist.id, name: gist.name, author: gist.author)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.state.status = .loaded(mainInformation)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.state.status = .error
                    }
            }
        }
    }
}
