//
//  ProductsService.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 19/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import Foundation

struct Response: Codable {
    var results: [Product]
}

enum ProductsServiceError : Error {
    case invalidSearchText
    case invalidURL
    case noData
    case errorDecodingJSON
}

protocol ProductsServiceProtocol {
    func fetchProducts(searchText: String, completion: @escaping ([Product]?, Error?) -> Void)
}

struct ProductsService : ProductsServiceProtocol {
    var session: URLSession
    
    static let baseURL = "https://api.mercadolibre.com/sites/MLA/search"
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchProducts (searchText: String, completion: @escaping ([Product]?, Error?) -> Void) {
        
        // Ensuring safe search string replacing not allowed characters
        guard let safeSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return DispatchQueue.main.async {
                return completion(nil, ProductsServiceError.invalidSearchText)//print("Invalid search text")
            }
        }
        
        // Creating url from baseURL + queryString
        guard let url = URL(string: "\(ProductsService.baseURL)?q=\(safeSearchText)") else {
            return DispatchQueue.main.async {
                completion(nil, ProductsServiceError.invalidURL)//print("Invalid URL")
            }
        }

        // Creating request from URL
        let request = URLRequest(url: url)

        // Triggering request through sharedInstance of URLSession
        session.dataTask(with: request) { data, response, error in
            // Handling response
            
            // Ensuring unwrapping received data
            guard let data = data else {
                return DispatchQueue.main.async {
                    completion(nil, ProductsServiceError.noData)//print("No data retreived from server, error: \(error?.localizedDescription ?? "Unknown error")")
                }
            }

            // Ensuring decoding JSON from response data using Response as type
            guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else {
                return DispatchQueue.main.async {
                    completion(nil, ProductsServiceError.errorDecodingJSON)//print("Error decoding JSON response")
                }
            }
            
            // Dispatching completion handler on main thread
            DispatchQueue.main.async {
                completion(decodedResponse.results, nil)
            }

        }.resume()
    }
}
