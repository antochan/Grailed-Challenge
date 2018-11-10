//
//  SavedSearchViewController.swift
//  Grailed_Challenge
//
//  Created by Antonio Chan on 2018/11/10.
//  Copyright © 2018 Antonio Chan. All rights reserved.
//

import UIKit

class SavedSearchViewController: UIViewController {
    
    @IBOutlet weak var productCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getProducts()
        setUpAppearances()
        setUpCollectionView()
    }
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshSearches), for: .valueChanged)
        return refreshControl
    }()
    
    func setUpAppearances() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: font.DidotBold, size: 24)!]
    }
    
    func setUpCollectionView() {
        productCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 0, right: 30)
        productCollectionView.collectionViewLayout = layout
        productCollectionView.refreshControl = refresher
    }
    
    func getProducts() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        SavedSearchServices.instance.getProducts { [weak self] (success) in
            
            guard let strongSelf = self else { return }
            
            if success {
                DispatchQueue.main.async {
                    self?.productCollectionView.reloadData()
                    UIViewController.removeSpinner(spinner: sv)
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Failed to retrieve your searches", preferredStyle: UIAlertController.Style.alert)
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
    
    @objc func refreshSearches() {
        SavedSearchServices.instance.products.removeAll()
        getProducts()
        productCollectionView.reloadData()
    }

}

extension SavedSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SavedSearchServices.instance.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        cell.update(product: SavedSearchServices.instance.products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 8
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: dim-30, height: dim+20)
    }
    
    
}
