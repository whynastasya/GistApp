//
//  AppCoordinator.swift
//  GistApp
//
//  Created by nastasya on 30.09.2024.
//

import UIKit

final class AppCoordinator: ICoordinator {
    var navigationController: UINavigationController
    
    private let networkService = NetworkService.shared
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showGistsListViewController()
    }
    
    func showGistsListViewController() {
        let gistsListViewModel = GistsListViewModel(networkService: networkService)
        gistsListViewModel.coordinatorDelegate = self
        let gistsListViewController = GistsListViewController(viewModel: gistsListViewModel)
        navigationController.pushViewController(gistsListViewController, animated: true)
    }
    
    func showGistDetailViewController(with id: String) {
        let gistDetailViewModel = GistDetailViewModel(gistId: id, networkService: networkService)
        let gistDetailViewController = GistDetailViewController(viewModel: gistDetailViewModel)
        navigationController.present(gistDetailViewController, animated: true)
    }
}

extension AppCoordinator: IGistsListCoordinator {
    func didSelectGist(with id: String) {
        showGistDetailViewController(with: id)
    }
}
