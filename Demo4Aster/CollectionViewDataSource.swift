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
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customcell", for: indexPath) as! CustomCell
        cell.descriptionLabel.text = products[indexPath.row].productDescription
        cell.descriptionHeight.constant = products[indexPath.row].productDescription.height(constraintedWidth: cell.frame.width, font: UIFont.systemFont(ofSize: 17.0))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let imageHeight = products[indexPath.row].image.height
        
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        let descriptionHeight = products[indexPath.row].productDescription.height(constraintedWidth: widthPerItem, font: UIFont.systemFont(ofSize: 17.0))
        let totalHeight = imageHeight + Int(descriptionHeight) + 80
        
        return CGSize(width:widthPerItem, height: CGFloat(totalHeight))
    }
}

extension CollectionViewDataSource : UICollectionViewDelegate {
   
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

