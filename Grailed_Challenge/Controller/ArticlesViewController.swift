//
//  ArticlesViewController.swift
//  Grailed_Challenge
//
//  Created by Antonio Chan on 2018/11/5.
//  Copyright © 2018 Antonio Chan. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {

    @IBOutlet weak var articleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArticles()
        setNavigationBarAttributes()
    }
    
    func setNavigationBarAttributes() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Didot-Bold", size: 24)!]
    }
    
    func getArticles() {
        ArticleServices.instance.getArticles { [weak self] (success) in
            
            guard let strongSelf = self else { return }
            
            if success {
                print(ArticleServices.instance.articles)
                DispatchQueue.main.async {
                    self?.articleTableView.reloadData()
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Failed to retrieve Articles", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
            }
        }
    }

}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticleServices.instance.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ArticleTableViewCell", owner: self, options: nil)?.first as! ArticleTableViewCell
        cell.selectionStyle = .none
        cell.update(article: ArticleServices.instance.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        height = 250
        return height
    }

    
}
