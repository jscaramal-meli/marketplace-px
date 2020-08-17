//
//  AnyViewModel.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 17/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import Combine
import Foundation

final class AnyViewModel<State, Input>: ViewModel {

    private let wrappedObjectWillChange: () -> AnyPublisher<Void, Never>
    private let wrappedState: () -> State
    private let wrappedTrigger: (Input) -> Void

    var objectWillChange: some Publisher {
        wrappedObjectWillChange()
    }

    var state: State {
        wrappedState()
    }

    func trigger(_ input: Input) {
        wrappedTrigger(input)
    }

    init<V: ViewModel>(_ viewModel: V) where V.State == State, V.Input == Input {
        self.wrappedObjectWillChange = { viewModel.objectWillChange.eraseToAnyPublisher() }
        self.wrappedState = { viewModel.state }
        self.wrappedTrigger = viewModel.trigger
    }

}
