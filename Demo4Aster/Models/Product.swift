//
//  Product.swift
//  Demo4Aster
//
//  Created by Kaustubh on 01/02/21.
//

import Foundation


struct ProductsResponse: Codable{
    let products: [Product]?
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let productName, productDescription: String
    let image: Image
    let price: Int
}

// MARK: - Image
struct Image: Codable {
    let width, height: Int
    let url: String
}
