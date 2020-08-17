//
//  ProductListViewModel.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 17/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import Foundation
import SwiftUI

enum ModelDataState: Equatable {
    static func == (lhs: ModelDataState, rhs: ModelDataState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
    case idle
    case loading
    case loaded
    case error(Error)
}


struct ProductsState {
    var products: [Product] = []
    var dataState: ModelDataState = .idle
    
    mutating func changeViewModelState(newViewModelState: ModelDataState) {
        dataState = newViewModelState
    }
}

enum ProductsInput {
    case fetchProducts
}
    
class ProductsViewModel : ViewModel {
    @Published var state: ProductsState
    
    init(state: ProductsState) {
        self.state = state
        self.state.changeViewModelState(newViewModelState: .loading)
        
    }
    
    
}

