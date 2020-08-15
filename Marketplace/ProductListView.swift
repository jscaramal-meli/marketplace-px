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
        guard let safeSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: "https://api.mercadolibre.com/sites/MLA/search?q=\(safeSearchText)") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return print("No data retreived from server, error: \(error?.localizedDescription ?? "Unknown error")")
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else {
                return print ("Error decoding JSON response")
            }
            
            DispatchQueue.main.async {
                self.productList = decodedResponse.results
            }
        }.resume()
        
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
