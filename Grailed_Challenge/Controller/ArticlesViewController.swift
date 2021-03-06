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
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArticles(page: pageNumber)
        setUpAppearances()
        articleTableView.refreshControl = refresher
    }
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshArticles), for: .valueChanged)
        return refreshControl
    }()
    
    //change navigation look bar function
    func setUpAppearances() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: font.DidotBold, size: 24)!]
    }
    
    //Network request with specific page number to get articles
    func getArticles(page: Int) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        ArticleServices.instance.getArticles(page: page) { [weak self] (success) in
            
            guard let strongSelf = self else { return }
    
            if success {
                DispatchQueue.main.async {
                    self?.articleTableView.reloadData()
                    UIViewController.removeSpinner(spinner: sv)
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Failed to retrieve Articles", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
                UIViewController.removeSpinner(spinner: sv)
            }
        }
        
        let deadline = DispatchTime.now() + .milliseconds(600)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.refresher.endRefreshing()
        }
    }
    
    //pull to refresh function call 
    @objc func refreshArticles() {
        ArticleServices.instance.articles.removeAll()
        pageNumber = 1
        getArticles(page: pageNumber)
        articleTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        
        if indexPath.row == totalRows - 1 {
            pageNumber += 1
            getArticles(page: pageNumber)
        }
    }

}
