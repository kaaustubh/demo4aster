//
//  ViewController.swift
//  Demo4Aster
//
//  Created by Kaustubh on 01/02/21.
//

import UIKit

protocol CollectionViewReloadDelegate {
    func loadNextsProducts()
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var products = [Product]()
    var lastProductId = 1
    var dataSource = CollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate = dataSource
        
        let layout = self.collectionView.collectionViewLayout as! CustomLayout
        layout.delegate = (dataSource as CustomLayoutDelegate)

        self.collectionView.setCollectionViewLayout(layout, animated: true)
        dataSource.delegate = self
        
        loadProducts()
    }
    
    func loadProducts() {
        ProductsService().loadProducts(offset: lastProductId, limit: 10) {[weak self] products, error in
            guard let self = self else {return}
            DispatchQueue.main.async{
                if error == nil {
                    if let products = products {
                        self.dataSource.appendProducts(newProducts: products)
                        if let last = products.last {
                            self.lastProductId = last.id + 1
                        }
                        let layout = self.collectionView.collectionViewLayout as! CustomLayout
                        self.collectionView.collectionViewLayout = layout
                        layout.prepare()
                        self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
                        self.collectionView.reloadData()
                    }
                    
                }
                else {
                    var message = "Something went wrong!!!"
                    if let errorcode = error?.code {
                        message = "Something went wrong. Error code- " + "\(errorcode)"
                    }
                    Alert.show(title: "Error", message: message, buttonTitle: "Ok")
                }
            }
        }
    }

}



extension ViewController : CollectionViewReloadDelegate {
    func loadNextsProducts() {
        loadProducts()
    }
}

