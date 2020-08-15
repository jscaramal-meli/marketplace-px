//
//  ProductListItemView.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 15/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import SwiftUI

struct ProductRowView: View {
    
    var product : Product
    
    var body: some View {
        HStack {
            Text(product.title)
            Spacer()
            Text("$\(product.price)")
        }
    }
}

struct ProductListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product: productsData[0])
    }
}
