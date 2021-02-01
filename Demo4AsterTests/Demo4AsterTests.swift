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
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetPosts() {
        let postsExpectation = expectation(description: "Get Products")
        _ = ProductsService().loadProducts(offset: offset, limit: limit, completion: { products,error in
            if let products = products, products.count == 10 {
                postsExpectation.fulfill()
            }
            
        })
        waitForExpectations(timeout: 3, handler: nil)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
