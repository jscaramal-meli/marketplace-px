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
    
    @State var productList : [Product] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Mostrando resultados de: \(self.searchText)")
            
            List(productList) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    ProductRowView(product: product)
                }
            }
        }.onAppear(perform: loadProducts)
    }
    
    func loadProducts() {
                
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(searchText: .constant("Search example"))
    }
}

struct Response: Codable {
    var results: [Product]
}
