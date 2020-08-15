//
//  ProductDetailView.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 13/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import SwiftUI

struct ProductDetailView: View {
    
    var productId : Int
    
    var body: some View {
        Text("Detalle del producto \(productId)")
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(productId: 1)
    }
}
