//
//  ProductDetailView.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 13/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import SwiftUI

struct ProductDetailView: View {
    
    @State var product : Product
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text("\(self.product.title)")
            Spacer()
            Text(self.product.description ?? "")
                .lineLimit(nil)
        }.onAppear(perform: loadDescription)
    }
    
    func loadDescription() {
        guard let url = URL(string: "https://api.mercadolibre.com/items/\(self.product.id)/description") else {
            return print("Invalid URL")
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return print("No data retreived from server, error: \(error?.localizedDescription ?? "Unknown error")")
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(DescriptionResponse .self, from: data) else {
                return print ("Error decoding JSON response")
            }
            
            DispatchQueue.main.async {
                self.product.description = decodedResponse.plain_text
            }
        }.resume()
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: productsData[0])
    }
}

struct DescriptionResponse: Codable {
    var plain_text : String
}
