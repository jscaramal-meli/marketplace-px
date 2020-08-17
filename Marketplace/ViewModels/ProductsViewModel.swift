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
        
        guard let safeSearchText = searchText.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: "https://api.mercadolibre.com/sites/MLA/search?q=\(safeSearchText)") else {
           print("Invalid URL")
           return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
               return print("No data retreived from server, error: \(error?.localizedDescription ?? "Unknown error")")
            }

            guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else {
               return print ("Error decoding JSON response")
            }
            
            var results : [Product] = []
            
            for result in decodedResponse.results {
                results.append(Product(id: result.id, title: result.title, price: result.price, stringPrice: String(format: "%.2f", result.price)))
            }

            //self.state = ProductsState(products: decodedResponse.results, dataState: .loaded, searchText: searchText)
            DispatchQueue.main.async {
                self.state.changeViewModelState(newViewModelState: .loaded)
                self.state.changeProducts(newProducts: results)
            }
        }.resume()
        
    }
    
    func trigger(_ input: ProductsInput) {
        switch input {
        case .fetchProducts:
            self.fetchProducts(searchText: self.state.searchText)
        case .cleanProducts:
            self.state.changeProducts(newProducts: [])
        default:
            print("Uninmplemented function")
        }
    }
}

struct Response: Codable {
    var results: [Product]
}

