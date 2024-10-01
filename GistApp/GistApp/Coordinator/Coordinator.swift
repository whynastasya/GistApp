//
//  Coordinator.swift
//  GistApp
//
//  Created by nastasya on 29.09.2024.
//

import UIKit

protocol ICoordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
