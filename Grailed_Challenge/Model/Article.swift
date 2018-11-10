//
//  Article.swift
//  Grailed_Challenge
//
//  Created by Antonio Chan on 2018/11/5.
//  Copyright © 2018 Antonio Chan. All rights reserved.
//

import Foundation

struct ArticleData: Decodable {
    let data : [Article]
}

struct Article: Decodable {
    let id: Int
    let url: String
    let title: String
    let published_at: String
    let published: Bool
    let hero: String
}


