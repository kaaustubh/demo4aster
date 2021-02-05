//
//  CollectionViewDataSource.swift
//  Demo4Aster
//
//  Created by Kaustubh on 02/02/21.
//

import Foundation
import UIKit

class CollectionViewDataSource: NSObject {
    var products = [Product]()
    var delegate : CollectionViewReloadDelegate?
    func appendProducts(newProducts: [Product]) {
        products.append(contentsOf: newProducts)
    }
}

extension CollectionViewDataSource : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customcell", for: indexPath) as! CustomCell
        let product = products[indexPath.item]
        cell.descriptionLabel.text = product.productDescription
        cell.imageHeight.constant = CGFloat(product.image.height)
        cell.descriptionHeight.constant = product.productDescription.height(constraintedWidth: cell.frame.width, font: UIFont.systemFont(ofSize: 20.0))
        if let placeholder = UIImage(named: "placeholder") {
            cell.imageView.imageURL(urlString: product.image.url, placeHolderImage: placeholder)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
}


extension CollectionViewDataSource: CustomLayoutDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    let imageHeight = products[indexPath.item].image.height
    
    let widthPerItem = collectionView.frame.width / 2 - 20
    
    let attString = NSAttributedString(string: products[indexPath.row].productDescription, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)])
    let r = attString.boundingRect(with: CGSize(width: widthPerItem, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
    let totalHeight = imageHeight + Int(r.height) + 100
    return CGFloat(totalHeight)
  }
}

extension CollectionViewDataSource : UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == products.count - 1 {
            guard let delegate = delegate  else {
                return
            }
            delegate.loadNextsProducts()
        }
    }
    
}

extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()

        return label.frame.height
 }
}

