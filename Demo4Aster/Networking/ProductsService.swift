//
//  PostsService.swift
//  Audi_list
//
//  Created by Kaustubh on 13/01/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import Foundation

class ProductsService {
    
    private let client = NetworkEngine(baseUrl: "https://aster.getsandbox.com")
    
    @discardableResult
    func loadProducts(offset: Int, limit: Int, completion: @escaping ([Product]?, CustomError?) -> ()) -> URLSessionDataTask? {
        let params: JSON = ["count": limit, "from": offset]
        
        return client.load(path: "/products", method: .get, params: params) { result, error in
            if (error != nil) {
                completion(nil, error)
            }
        
            else if (result != nil) {
                do {
                    let postResponse = try JSONDecoder().decode([Product].self, from: result as! Data)
                    completion(postResponse, nil)
                } catch {
                    print(error)
                }
            }
            else {
                completion(nil, CustomError(code: 405, type: "NoResult", message: "No results found"))
            }
        }
    }
}
