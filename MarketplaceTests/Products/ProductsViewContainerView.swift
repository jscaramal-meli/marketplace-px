//
//  ProductsViewContainerView.swift
//  MarketplaceTests
//
//  Created by Jonathan Scaramal on 23/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import SwiftUI

struct ProductsViewContainerView: View {
    @Binding var searchText : String
    
    var body: some View {
        ProductsView(searchText: $searchText)
    }
}

struct ProductsViewContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsViewContainerView(searchText: .constant(""))
    }
}
