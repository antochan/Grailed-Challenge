//
//  ProductCollectionViewCell.swift
//  Grailed_Challenge
//
//  Created by Antonio Chan on 2018/11/10.
//  Copyright © 2018 Antonio Chan. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var productImageView: CustomImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    
    func update(product: Product) {
        let productImageURL = newImageUrl(product.image_url, Int(UIScreen.main.bounds.width))
        productImageView.loadImageUsingUrlString(productImageURL)
        productNameLabel.text = product.name
    }

}
