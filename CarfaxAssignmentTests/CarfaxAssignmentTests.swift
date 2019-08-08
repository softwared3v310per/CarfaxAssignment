//
//  CarfaxAssignmentTests.swift
//  CarfaxAssignmentTests
//
//  Created by Mbah Fonong on 8/8/19.
//  Copyright © 2019 Mbah Fonong. All rights reserved.
//

import XCTest
@testable import CarfaxAssignment

class CarfaxAssignmentTests: XCTestCase {

    let viewModel = CarSearchViewModel()
    let testPhoto = URL(string: "https://carfax-img.vast.com/carfax/-9050308143659109979/1/344x258")!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONEndpoint() {
        let expectation = XCTestExpectation(description: "JSON Endpoint")
        self.viewModel.getCarListings { carmodels in
            if let _ = carmodels {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testPhotoEndpoint() {
        let expectation = XCTestExpectation(description: "Photo Endpoint")
        
        self.viewModel.getPhotoData(url: testPhoto) { photoData in
            if let _ = photoData {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 3)
    }

}
