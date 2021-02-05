//
//  DetailViewController.swift
//  Demo4Aster
//
//  Created by Kaustubh on 05/02/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        guard let product = product else{
            return
        }
        self.priceLabel.text = "$\(product.price)"
        self.imageView.imageURL(urlString: product.image.url, placeHolderImage: UIImage.init(named: "placeholder"))
    }
    
    
}


