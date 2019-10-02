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
    let yourCarsViewModel = YourCarsViewModel()
    let testPhoto = URL(string: "https://carfax-img.vast.com/carfax/-9050308143659109979/1/344x258")!
    
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
    
    func testRealmSaveAndDelete() {
        let initialCount = self.yourCarsViewModel.fetchListings()?.count ?? 0
        
        let dummyCar = CarModel(make: "make", model: "model", mileage: 0, listPrice: 0, year: 2015, trim: "trim", id: "555", images: nil, dealer: Dealer(city: "Seattle", state: "Washington", phone: "0"))

        self.viewModel.saveListing(model: dummyCar, imageData: Data())
        let newCount = self.yourCarsViewModel.fetchListings()?.count ?? 0
        XCTAssertEqual(newCount, initialCount + 1)
        
        self.yourCarsViewModel.deleteListing(id: "555")
        let adjustedCount = self.yourCarsViewModel.fetchListings()?.count ?? 0
        XCTAssertEqual(adjustedCount, initialCount)
    }
}
