//
//  ArticleServices.swift
//  Grailed_Challenge
//
//  Created by Antonio Chan on 2018/11/5.
//  Copyright © 2018 Antonio Chan. All rights reserved.
//

import Foundation

class ArticleServices {
    
    static let instance = ArticleServices()
    
    var articles = [Article]()
    
    func getArticles(completion: @escaping CompletionHandler) {
        let articleURLString = API.articleURL
        guard let url = URL(string: articleURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Data.self, from: data)
                self.articles = result.data
                completion(true)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completion(false)
            }
        }.resume()
    }
    
}
