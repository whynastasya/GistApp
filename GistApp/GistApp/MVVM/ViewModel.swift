//
//  ViewModel.swift
//  GistApp
//
//  Created by nastasya on 26.09.2024.
//

import Foundation

protocol ViewModel {
    associatedtype State
    associatedtype Action
    
    var state: State { get }
    
    func subscribe(_ subscription: @escaping (State) -> Void)
    func handle(_ action: Action)
}
