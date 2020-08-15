//
//  ProductListView.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 13/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import SwiftUI

struct ProductListView: View {
    @Binding var searchText : String
    
    @State var productList : Array<ProductListItem> = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Mostrando resultados de: \(self.searchText)")
            
            List(productListData) { productListItem in
                NavigationLink(destination: ProductDetailView(productId: productListItem.id)) {
                    ProductListItemView(productListItem: productListItem)
                }
            }
        }.onAppear {
            // TODO: Fetch productos
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(searchText: .constant("Search example"))
    }
}
