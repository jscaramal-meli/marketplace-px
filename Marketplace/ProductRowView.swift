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
        VStack(alignment: .leading, spacing: 8) {
            Text(product.title)
                .padding(.top, 16)
                .padding(.leading, 16)
                .font(.system(size: 22))
                .foregroundColor(Color.init(hex: "00171F"))
            
            Text("$\(self.product.stringPrice ?? "0")")
                .padding(.leading, 16)
                .font(.system(size: 36))
                .foregroundColor(Color.init(hex: "007EA7"))
        }
    }
}

struct ProductListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product: productsData[0])
    }
}
