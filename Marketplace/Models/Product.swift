//
//  ProductListItem.swift
//  Marketplace
//
//  Created by Jonathan Scaramal on 15/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

struct Product : Codable, Identifiable {
    var id: String
    var title: String
    var price: Float
    var stringPrice: String?
    var description: String?
}
