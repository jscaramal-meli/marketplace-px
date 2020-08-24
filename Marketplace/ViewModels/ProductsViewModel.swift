//
//  ProductListViewModel.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 17/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

enum ModelDataState: Equatable {
    static func == (lhs: ModelDataState, rhs: ModelDataState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
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

enum ProductsViewModelError : Error {
    case errorFetchingProducts
}


struct ProductsState {
    var products: [Product] = []
    var dataState: ModelDataState = .idle
    var searchText: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    
    mutating func changeViewModelState(newViewModelState: ModelDataState) {
        dataState = newViewModelState
    }
    
    mutating func changeProducts(newProducts: [Product]) {
        products = newProducts
    }
}

enum ProductsInput {
    case fetchProducts
    case cleanProducts
}
    
class ProductsViewModel : ViewModel {
    @Published var state: ProductsState
    
    var productsService : ProductsServiceProtocol
    
    init(state: ProductsState, productsService: ProductsServiceProtocol = ProductsService(session: URLSession.shared)) {
        self.state = state
        
        self.productsService = productsService
    }
    
    func fetchProducts(searchText: CurrentValueSubject<String, Never>) {
        
        switch self.state.dataState {
        case .idle:
            // If it's on idle state then fetch products
            break
        default:
            // Else don't
            return
        }
        
        print("Fetching \(searchText.value)")
        
        // Changing state with .loading value for modelState
        self.state.changeViewModelState(newViewModelState: .loading)
        
        // Fetching products from API
        productsService.fetchProducts(searchText: searchText.value) { products, error in
            
            guard let products = products else {
                return self.state.changeViewModelState(newViewModelState: .error(ProductsViewModelError.errorFetchingProducts))
            }
            
            var newProducts : [Product] = []
            
            // Applying transformation logic after fetching
            for product in products {
                newProducts.append(Product(id: product.id, title: product.title, price: product.price, stringPrice: String(format: "%.2f", product.price)))
            }
            
            // Changing state with .loaded value for modelState
            self.state.changeViewModelState(newViewModelState: .loaded)
            // Changing state adding recently fetched products
            self.state.changeProducts(newProducts: newProducts)
          
        }
    }
    
    func cleanProducts () {
        self.state.changeViewModelState(newViewModelState: .idle)
        self.state.changeProducts(newProducts: [])
    }
    
    func trigger(_ input: ProductsInput) {
        switch input {
        case .fetchProducts:
            self.fetchProducts(searchText: self.state.searchText)
        case .cleanProducts:
            self.cleanProducts()
        }
    }
}
