//
//  ImageDownloader.swift
//  Audi_list
//
//  Created by Kaustubh on 13/01/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader: NSObject {
    
    static let shared = ImageDownloader()
    
    func downloadImage(from url: String, completion: @escaping (UIImage?, CustomError?) -> ()) {
        if let image = localImage(for: url) {
            completion(image, nil)
            return
        }
        let client = NetworkEngine(baseUrl: url)
        _ = client.load(path: "", method: .get, params: [:]) {result, error in
            if (error != nil) {
                completion(nil, error)
            }
            else if let data = result as? Data {
                let image = UIImage(data: data)
                self.saveImage(image: image!, at: url)
                completion(image, nil)
            }
            else {
                completion(nil, CustomError(code: 405, type: "NoResult", message: "No results found"))
            }
        }
    }
    
    func saveImage(image: UIImage, at path: String) {
        let localpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: localpath)
        if let imageName = base64EncodedName(for: path) {
            if let pathComponent = url.appendingPathComponent(imageName) {
                if let data = image.pngData() {
                    do {
                        try data.write(to: pathComponent as URL)
                    }
                    catch {
                        print("Error in writing data")
                    }
                }
            }
        }
    }
    
    func localImage(for imageurl: String) -> UIImage? {
         let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let url = NSURL(fileURLWithPath: path)
        if let imageName = base64EncodedName(for: imageurl) {
            if let pathComponent = url.appendingPathComponent(imageName) {
                let filePath = pathComponent.path
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: filePath) {
                    return nil
//                    return UIImage(contentsOfFile: filePath)
                } else {
                    return nil
                }
        } else {
            return nil
            }
        }
        else {
            return nil
        }
    }
    
    func base64EncodedName(for imageurl: String) -> String? {
        let utf8str = imageurl.data(using: .utf8, allowLossyConversion: true)
        if let base64Encoded = utf8str?.base64EncodedString() {
            return base64Encoded
        }
        return nil
    }
}
