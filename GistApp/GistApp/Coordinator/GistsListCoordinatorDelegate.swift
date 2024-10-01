//
//  GistsListCoordinatorDelegate.swift
//  GistApp
//
//  Created by nastasya on 30.09.2024.
//

import Foundation

protocol IGistsListCoordinator: AnyObject {
    func didSelectGist(with id: String)
}
