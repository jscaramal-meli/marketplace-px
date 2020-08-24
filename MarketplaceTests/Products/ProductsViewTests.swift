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

    func testErrorState() throws {
        let viewModel = ProductsViewModel.init(state: ProductsState.init(products: [], dataState: ModelDataState.error(ProductsViewModelError.errorFetchingProducts), searchText: CurrentValueSubject<String, Never>("Batidora Kitchenaid")))

        let containerView = ProductsViewContainerView(searchText: .constant("Batidora Kitchenaid")).environmentObject(AnyViewModel(viewModel))//ProductsView.init(searchText: .constant(""))
                
        let hostingVC = UIHostingController(rootView: containerView)
        
        hostingVC.view.layer.speed = 0
        
        assertSnapshot(matching: hostingVC, as: .image(on: .iPhoneX))
    }

    func testEmptyProductsState() throws {
        let viewModel = ProductsViewModel.init(state: ProductsState.init(products: [], dataState: .idle, searchText: CurrentValueSubject<String, Never>("")))

        let containerView = ProductsViewContainerView(searchText: .constant("Xiaomi MI Band 5")).environmentObject(AnyViewModel(viewModel))//ProductsView.init(searchText: .constant(""))
                
        let hostingVC = UIHostingController(rootView: containerView)
        
        hostingVC.view.layer.speed = 0
        
        assertSnapshot(matching: hostingVC, as: .image(on: .iPhoneX))
    }

    func testSomeProductsState() throws {
        let viewModel = ProductsViewModel.init(state: ProductsState.init(products: productsData, dataState: .loaded, searchText: CurrentValueSubject<String, Never>("Batidora Kitchenaid")))

        let containerView = ProductsViewContainerView(searchText: .constant("Batidora Kitchenaid")).environmentObject(AnyViewModel(viewModel))//ProductsView.init(searchText: .constant(""))
                
        let hostingVC = UIHostingController(rootView: containerView)
        
        hostingVC.view.layer.speed = 0
        
        assertSnapshot(matching: hostingVC, as: .image(on: .iPhoneX))
    }
}

