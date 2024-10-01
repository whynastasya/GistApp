//
//  GistDetailViewModel.swift
//  GistApp
//
//  Created by nastasya on 26.09.2024.
//

import Foundation

final class GistDetailViewModel: ObservableViewModel {
    @Published var state: GistDetailState
    private let gistId: String
    private let networkService: INetworkService
    
    init(state: GistDetailState = .init(status: .loading), gistId: String, networkService: INetworkService) {
        self.state = state
        self.gistId = gistId
        self.networkService = networkService
    }
    
    func handle(_ action: GistDetailAction) {
        switch action {
            case .viewDidLoad, .didTappedRestartButton:
                fetchGist()
            case .refresh:
                reloadGist()
        }
    }
    
    private func fetchGist() {
        state.status = .loading
        
        networkService.fetchGist(for: gistId) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let gist):
                    DispatchQueue.main.async {
                        self.state.status = .loaded(gist)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.state.status = .error
                    }
            }
        }
    }
    
    private func reloadGist() {
        networkService.fetchGist(for: gistId) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let gist):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.state.status = .loaded(gist)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.state.status = .error
                    }
            }
        }
    }
}
