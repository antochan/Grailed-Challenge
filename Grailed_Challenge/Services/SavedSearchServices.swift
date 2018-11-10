//
//  SavedSearchServices.swift
//  Grailed_Challenge
//
//  Created by Antonio Chan on 2018/11/10.
//  Copyright © 2018 Antonio Chan. All rights reserved.
//

import Foundation

class SavedSearchServices {
    
    static let instance = SavedSearchServices()
    
    var products = [Product]()
    
    func getProducts(completion: @escaping CompletionHandler) {
        let articleURLString = API.savedSearchURL
        guard let url = URL(string: articleURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(ProductData.self, from: data)
                self.products = result.data
                completion(true)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completion(false)
            }
        }.resume()
    }
    
}
