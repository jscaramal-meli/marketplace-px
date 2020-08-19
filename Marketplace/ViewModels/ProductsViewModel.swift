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
    
    init(state: ProductsState) {
        self.state = state
    }
    
    func fetchProducts(searchText: CurrentValueSubject<String, Never>) {
        
        print("Fetching \(searchText.value)")
        
        // Fetching products from API
        ProductsService.fetchProducts(searchText: searchText.value) { products, error in
            
            guard let products = products else {
                return print("Error fetching products")
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
    
    func trigger(_ input: ProductsInput) {
        switch input {
        case .fetchProducts:
            self.fetchProducts(searchText: self.state.searchText)
        case .cleanProducts:
            self.state.changeProducts(newProducts: [])
        }
    }
}

