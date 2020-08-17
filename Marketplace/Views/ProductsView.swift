//
//  ProductsView.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 17/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import SwiftUI

struct ProductsView: View {
    @Binding var searchText : String
    
    @EnvironmentObject
    var viewModel: AnyViewModel<ProductsState, ProductsInput>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(self.searchText)
                .padding(.top, 16)
                .padding(.leading, 16)
                .font(.system(size: 40))
                .foregroundColor(Color.init(hex: "003459"))
            
            List(self.viewModel.state.products) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    ProductRowView(product: product)
                }
            }
        }
        .onAppear(perform: fetchProducts)
        .onDisappear(perform: cleanProducts)
    
    }
    
    func cleanProducts() {
        viewModel.trigger(.cleanProducts)
    }
    
    func fetchProducts() {
        print("Sending bound search text: \(searchText)")
        viewModel.state.searchText.send(self.searchText)
        print("Now state search text is: \(viewModel.state.searchText.value)")
        viewModel.trigger(.fetchProducts)
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(searchText: .constant("Search example"))
    }
}
