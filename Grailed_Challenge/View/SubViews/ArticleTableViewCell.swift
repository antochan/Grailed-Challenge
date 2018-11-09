//
//  ArticleTableViewCell.swift
//  Grailed_Challenge
//
//  Created by Antonio Chan on 2018/11/8.
//  Copyright © 2018 Antonio Chan. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var articleImageView: CustomImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization Code
    }
    
    func update(article: Article) {
        articleTitleLabel.text = article.title
        let articleImageURL = newImageUrl(article.hero, Int(UIScreen.main.bounds.width))
        articleImageView.loadImageUsingUrlString(articleImageURL)
    }
    
}
