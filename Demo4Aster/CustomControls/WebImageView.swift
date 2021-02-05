//
//  WebImageView.swift
//  Demo4Aster
//
//  Created by Kaustubh on 05/02/21.
//

import Foundation
import UIKit

extension UIImageView {

public func imageURL(urlString: String, placeHolderImage: UIImage?) {
    let defaultImage = UIImage.init(named: "placeholder")
       if self.image == nil, let placeHolderImage = placeHolderImage {
        self.image = placeHolderImage
       } else {
        self.image = defaultImage
       }

       URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

           if error != nil {
               print(error ?? "No Error")
               return
           }
           DispatchQueue.main.async(execute: { () -> Void in
               let image = UIImage(data: data!)
               self.image = image
           })

       }).resume()
    }
    
}
