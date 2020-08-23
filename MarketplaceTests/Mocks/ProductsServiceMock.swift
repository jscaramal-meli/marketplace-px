//
//  ProductsServiceMock.swift
//  MarketplaceTests
//
//  Created by Jonathan Scaramal on 23/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import Foundation

struct ProductsServiceMock : ProductsServiceProtocol {
    
    static var testSearchs = [String: [Product]]()
    
    init(session: URLSession?) {
    }
    
    func fetchProducts (searchText: String, completion: @escaping ([Product]?, Error?) -> Void) {
        
        if let products = ProductsServiceMock.testSearchs[searchText] {
            // If there is products for this searchText
            completion(products, nil)
        } else {
            // If there isn't products for this searchText
            completion(nil, ProductsServiceError.noData)
        }

    }
}
