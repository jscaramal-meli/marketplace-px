//
//  ProductListItemView.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 15/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import SwiftUI

struct ProductListItemView: View {
    
    var productListItem : ProductListItem
    
    var body: some View {
        HStack {
            Text(productListItem.name)
            Spacer()
            Text("$\(productListItem.price)")
        }
    }
}

struct ProductListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListItemView(productListItem: productListData[0])
    }
}
