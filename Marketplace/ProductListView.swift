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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Lista de productos")
            
            Text("Buscaste: \(self.searchText)")
            
            NavigationLink(destination: ProductDetailView()) {
               Text("Ir al detalle del producto")
            }.buttonStyle(DefaultButtonStyle())
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(searchText: .constant("Search example"))
    }
}
