//
//  ProductsViewModelTests.swift
//  MarketplaceTests
//
//  Created by Jonathan Scaramal on 23/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import XCTest
import Combine

class ProductsViewModelTests: XCTestCase {

    func testEmptyListRender() throws {
        let searchText = "empty list"
        
        ProductsServiceMock.testSearchs = [searchText: []]
        
        let productsViewModel = ProductsViewModel.init(state: ProductsState.init(), productsService: ProductsServiceMock.init(session: nil))
        
        XCTAssertEqual(productsViewModel.state.dataState, ModelDataState.idle, "State should be idle")
        XCTAssertEqual(productsViewModel.state.searchText.value, "", "Search text should match")
        XCTAssertEqual(productsViewModel.state.products.count, 0, "Products list should be empty")
        
        let exp = expectation(description: "Correct values of " + String(describing: productsViewModel.$state))
        
        var sinkCount = 0
        
        let cancellable = productsViewModel.$state
            // Skip first change from state init
            .dropFirst()
            .sink(receiveValue: { state in
                
                sinkCount += 1
                
                switch sinkCount {
                case 1:
                    // First change, set loading
                    XCTAssertEqual(state.dataState, .loading, "State should be loading")
                    XCTAssertEqual(state.searchText.value, searchText, "Search text should match")
                    XCTAssertEqual(state.products.count, 0, "Products list should be empty")
                    break
                case 2:
                    // Second change, set loaded
                    XCTAssertEqual(state.dataState, .loaded, "State should be loaded")
                    XCTAssertEqual(state.searchText.value, searchText, "Search text should match")
                    XCTAssertEqual(state.products.count, 0, "Products list should still be empty")
                    break
                case 3:
                    // Third change, set products list
                    XCTAssertEqual(state.dataState, .loaded, "State should be loaded")
                    XCTAssertEqual(state.searchText.value, searchText, "Search text should match")
                    XCTAssertEqual(state.products.count, 0, "Products list count should be 0")
                    exp.fulfill()
                default:
                    break
                }
            })
        
        productsViewModel.state.searchText.send(searchText)
        productsViewModel.trigger(.fetchProducts)
        
        wait(for: [exp], timeout: 1)
        // Keep reference of cancellable to prevent ARC destroying sink
        XCTAssertNotNil(cancellable)
        
    }

    func testSomeProductsListRender() throws {
        let searchText = "iPhone"
        
        ProductsServiceMock.testSearchs = [searchText: productsData]
        
        let productsViewModel = ProductsViewModel.init(state: ProductsState.init(), productsService: ProductsServiceMock.init(session: nil))
        
        XCTAssertEqual(productsViewModel.state.dataState, ModelDataState.idle, "State should be idle")
        XCTAssertEqual(productsViewModel.state.searchText.value, "", "Search text should match")
        XCTAssertEqual(productsViewModel.state.products.count, 0, "Products list should be empty")

        let exp = expectation(description: "Correct values of " + String(describing: productsViewModel.$state))
        
        var sinkCount = 0
        
        let cancellable = productsViewModel.$state
            // Skip first change from state init
            .dropFirst()
            .sink(receiveValue: { state in
                
                sinkCount += 1
                
                switch sinkCount {
                case 1:
                    // First change, set loading
                    XCTAssertEqual(state.dataState, .loading, "State should be loading")
                    XCTAssertEqual(state.searchText.value, searchText, "Search text should match")
                    XCTAssertEqual(state.products.count, 0, "Products list should be empty")
                    break
                case 2:
                    // Second change, set loaded
                    XCTAssertEqual(state.dataState, .loaded, "State should be loaded")
                    XCTAssertEqual(state.searchText.value, searchText, "Search text should match")
                    XCTAssertEqual(state.products.count, 0, "Products list should still be empty")
                    break
                case 3:
                    // Third change, set products list
                    XCTAssertEqual(state.dataState, .loaded, "State should be loaded")
                    XCTAssertEqual(state.searchText.value, searchText, "Search text should match")
                    XCTAssertEqual(state.products.count, 3, "Products list count should be 3")
                    
                    // Assert product id
                    XCTAssertEqual(state.products[0].id, "1", "ID should be passed ok")
                    // Assert product title
                    XCTAssertEqual(state.products[0].title, "Batidora Kitchenaid Artisan", "Title should be passed ok")
                    // Assert product price
                    XCTAssertEqual(state.products[0].price, 49999, "Price should be passed okk")
                    // Assert stringPrice transformation
                    XCTAssertEqual(state.products[0].stringPrice, "49999.00", "Price should be formatted with two decimals")
                    
                    exp.fulfill()
                default:
                    break
                }
            })
        
        productsViewModel.state.searchText.send(searchText)
        productsViewModel.trigger(.fetchProducts)
        
        wait(for: [exp], timeout: 1)
        // Keep reference of cancellable to prevent ARC destroying sink
        XCTAssertNotNil(cancellable)
        
    }

}
