//
//  ProductsViewModelTest.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 20/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import XCTest

class ProductsServiceTests: XCTestCase {

    func testErrorAPIResponse() throws {
        let searchText = "error search"

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        
        let productsService = ProductsService.init(session: session)
        
        let asyncExpectation = expectation(description: "Async block executed")
        
        productsService.fetchProducts(searchText: searchText) { products, error in
        
            XCTAssertNil(products, "Products should be nil")
            
            guard let error = error else {
                return XCTFail("Error shouldn't be nil")
            }
            
            XCTAssertEqual( error as! ProductsServiceError, .noData)
            
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testEmptyAPIResponse() throws {
        let searchText = "empty list"
        
        let url = URL(string: "\(ProductsService.baseURL)?q=empty%20list")
        
        // attach that to some fixed filename in our protocol handler
        URLProtocolMock.testURLs = [url: "EmptyProductsMock"]

        // now set up a configuration to use our mock
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]

        // and create the URLSession from that
        let session = URLSession(configuration: config)
        
        let productsService = ProductsService.init(session: session)
        
        let asyncExpectation = expectation(description: "Async block executed")
        
        productsService.fetchProducts(searchText: searchText) { products, error in
            XCTAssertNil(error, "Error should be nil")
            
            guard let products = products else {
                return XCTFail("Products should be unwrappeable")
            }
            
            XCTAssertEqual(products.count, 0, "Products list should be empty")
            
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSomeAPIResponse() throws {
        let searchText = "iPhone"
        
        let url = URL(string: "\(ProductsService.baseURL)?q=iPhone")
        
        // attach that to some fixed filename in our protocol handler
        URLProtocolMock.testURLs = [url: "SomeProductsMock"]

        // now set up a configuration to use our mock
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]

        // and create the URLSession from that
        let session = URLSession(configuration: config)
        
        let productsService = ProductsService.init(session: session)
        
        let asyncExpectation = expectation(description: "Async block executed")
        
        productsService.fetchProducts(searchText: searchText) { products, error in
            XCTAssertNil(error, "Error should be nil")
            
            guard let products = products else {
                return XCTFail("Products should be unwrappeable")
            }
            
            XCTAssertEqual(products.count, 50, "Products list shouldn't be empty")
            
            let firstProduct = products[0]
            
            XCTAssertEqual(firstProduct.id, "MLA869200110", "Product id should match")
            XCTAssertEqual(firstProduct.title, "iPhone 7 128 Gb Negro Brillante 2 Gb Ram", "Product title should match")
            XCTAssertEqual(firstProduct.price, 98989.99, "Product price should match")
            
            asyncExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }

}
