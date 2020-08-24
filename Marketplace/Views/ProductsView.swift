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
            HStack {
                Text(self.searchText)
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .font(.system(size: 40))
                    .foregroundColor(Color.init(hex: "003459"))
                Spacer()
            }
            
                        
            content

        }
        .frame(maxWidth: .infinity)
        .frame(alignment: .leading)
        .onAppear(perform: fetchProducts)
        .onDisappear(perform: cleanProducts)
    
    }
    
    private var content: some View {
        switch viewModel.state.dataState {
        case .idle:
            return Color.clear.eraseToAnyView()
        case .loading:
            return
                VStack {
                    Spacer()
                    Text("Estamos buscando tu producto")
                    Spacer()
                }
            .frame(maxWidth: .infinity).eraseToAnyView()
        case .error( _):
        return
            VStack {
                Spacer()
                Text("Oops, algo salió mal!")
                Spacer()
            }
            .frame(maxWidth: .infinity).eraseToAnyView()
        case .loaded:
            return List(self.viewModel.state.products) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    ProductRowView(product: product)
                }
            }.eraseToAnyView()
        }
    }
    
    func cleanProducts() {
        viewModel.trigger(.cleanProducts)
    }
    
    func fetchProducts() {
        viewModel.state.searchText.send(self.searchText)
        viewModel.trigger(.fetchProducts)
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        let preview = ProductsView(searchText: .constant("Search example"))
        return preview
    }
}
