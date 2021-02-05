//
//  Demo4AsterTests.swift
//  Demo4AsterTests
//
//  Created by Kaustubh on 01/02/21.
//

import XCTest
@testable import Demo4Aster

class Demo4AsterTests: XCTestCase {

    let offset = 1
    let limit = 10
    
    var products = [Product]()
    
    override func setUpWithError() throws {
        let p1 = Product(id: 1, productName: "n1", productDescription: "pd1", image: Image(width: 12, height: 12, url: "url"), price: 45)
        let p2 = Product(id: 2, productName: "n2", productDescription: "pd2", image: Image(width: 12, height: 12, url: "url"), price: 45)
        let p3 = Product(id: 3, productName: "n3", productDescription: "pd3", image: Image(width: 12, height: 12, url: "url"), price: 45)
        products.append(p1)
        products.append(p2)
        products.append(p3)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetProducts() {
        let postsExpectation = expectation(description: "Get Products")
        _ = ProductsService().loadProducts(offset: offset, limit: limit, completion: { products,error in
            if let products = products, products.count == 10 {
                postsExpectation.fulfill()
            }
            
        })
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testSave() {
        try? LocalStorage().save(products: products)
        let retrived = try? LocalStorage().retriveProducts()
        
        XCTAssertEqual(retrived?.count, products.count)
        if let first = retrived?.first {
            XCTAssertEqual(first.id, products[0].id)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
