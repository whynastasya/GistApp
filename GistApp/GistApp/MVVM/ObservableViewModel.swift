//
//  ObservableViewModel.swift
//  Aviasales
//
//  Created by nastasya on 26.09.2024.
//

import Foundation
import Combine

protocol ObservableViewModel: ViewModel, ObservableObject {}

extension ObservableViewModel {
    var statePublisher: AnyPublisher<(old: State, new: State), Never> {
        var initialState: State?
        return objectWillChange
            .map { _ in
                initialState = initialState ?? self.state
            }
            .receive(on: DispatchQueue.main)
            .compactMap { _ in
                if let old = initialState {
                    initialState = nil
                    return (old: old, new: self.state)
                }
                return nil
            }
            .eraseToAnyPublisher()
    }
    
    func subscribe(_ subscription: @escaping (State) -> Void) {
        assertionFailure("Use \'subscribel_ subscription: @escaping (State) -> Void) -> Cancellable\' insead")
    }
    
    func subscribe(_ subscription: @escaping (State) -> Void) -> AnyCancellable {
        return objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                subscription(self.state)
            }
    }
}
