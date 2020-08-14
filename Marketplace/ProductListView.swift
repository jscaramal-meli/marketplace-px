//
//  ProductListView.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 13/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import SwiftUI

struct ProductListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Product list view")
            
            NavigationLink(destination: ProductListView()) {
               Text("Navigate to Product Detail")
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
