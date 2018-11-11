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
        //adding gradient background to image view
        articleImageView.addBlackGradientLayer(frame: articleImageView.frame, colors: [.clear, UIColor.black.withAlphaComponent(0.55)])
    }
    
    func update(article: Article) {        
        let articleLabelText = article.title + "\n" + dateTransformer(article.published_at)
        articleTitleLabel.text = articleLabelText
        let articleImageURL = newImageUrl(article.hero, Int(UIScreen.main.bounds.width))
        articleImageView.loadImageUsingUrlString(articleImageURL)
    }
    
}
