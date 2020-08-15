//
//  ProductListItem.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 15/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

struct ProductListItem : Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var price: Int
}
