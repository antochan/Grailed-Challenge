//
//  Product.swift
//  Grailed_Challenge
//
//  Created by Antonio Chan on 2018/11/10.
//  Copyright © 2018 Antonio Chan. All rights reserved.
//

import Foundation

struct ProductData: Decodable {
    let data : [Product]
}

struct Product: Decodable {
    let id: Int
    let name: String
    let image_url: String
    let published_at: String
}
