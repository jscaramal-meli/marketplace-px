//
//  ProductsViewTests.swift
//  MarketplaceTests
//
//  Created by Jonathan Scaramal on 23/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

import XCTest

import SnapshotTesting

class ProductsViewTests: XCTestCase {

    func testEmptyProductsState() throws {
        let viewModel = ProductsViewModel.init(state: ProductsState.init(products: [], dataState: .idle, searchText: CurrentValueSubject<String, Never>("")))

        let containerView = ProductsViewContainerView(searchText: .constant("Xiaomi MI Band 5")).environmentObject(AnyViewModel(viewModel))//ProductsView.init(searchText: .constant(""))
                
        let hostingVC = UIHostingController(rootView: containerView)
        
        hostingVC.view.layer.speed = 0
        
        assertSnapshot(matching: hostingVC, as: .image(on: .iPhoneX))
    }

    func testSomeProductsState() throws {
        let viewModel = ProductsViewModel.init(state: ProductsState.init(products: productsData, dataState: .loaded, searchText: CurrentValueSubject<String, Never>("Sarasa")))

        let containerView = ProductsViewContainerView(searchText: .constant("Batidora Kitchenaid")).environmentObject(AnyViewModel(viewModel))//ProductsView.init(searchText: .constant(""))
                
        let hostingVC = UIHostingController(rootView: containerView)
        
        hostingVC.view.layer.speed = 0
        
        assertSnapshot(matching: hostingVC, as: .image(on: .iPhoneX))
        
//        let exp = expectation(description: "Expecting app state to assert snapshot")
//
//        var sinkCount = 0
//
//        let cancellable = viewModel.$state.sink(receiveValue: { state in
//            sinkCount += 1
//            print(state.searchText.value)
//            if(sinkCount == 2) {
//                assertSnapshot(matching: hostingVC, as: .image(on: .iPhoneX), record: true)
//                exp.fulfill()
//            }
//        })
//
//        wait(for: [exp], timeout: 5)
//        // Keep reference of cancellable to prevent ARC destroying sink
//        XCTAssertNotNil(cancellable)
    }
}

