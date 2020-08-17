////
////  ProductService.swift
////  Marketplace
////
////  Created by Jonathan Scaramal on 17/08/2020.
////  Copyright © 2020 jkdev. All rights reserved.
////
//
//class ProductService {
//    
//    func listProducts(search: String, completion: ([Product]?) -> ()) {
//        guard let safeSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: "https://api.mercadolibre.com/sites/MLA/search?q=\(safeSearchText)") else {
//            print("Invalid URL")
//            return
//        }
//        
//        let request = URLRequest(url: url)
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                return print("No data retreived from server, error: \(error?.localizedDescription ?? "Unknown error")")
//            }
//            
//            guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else {
//                return print ("Error decoding JSON response")
//            }
//            
//            DispatchQueue.main.async {
//                completion(decodedResponse.results)
//            }
//        }.resume()
//
//    }
//}
