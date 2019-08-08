//
//  CarSearchViewModel.swift
//  CarfaxAssignment
//
//  Created by Mbah Fonong on 8/7/19.
//  Copyright © 2019 Mbah Fonong. All rights reserved.
//

import Foundation

class CarSearchViewModel {
    func getCarListings(completion: @escaping ([CarModel]?) -> ())  {
        if let url = URL(string: "https://carfax-for-consumers.firebaseio.com/assignment.json") {
            CarSearchWorker.getData(url: url) { (data, error) in
                if let data = data, let carModels = CarSearchWorker.parseData(data: data) {
                    completion(carModels.listings)
                } else {
                    print("Error getting data: \(String(describing: error))")
                    completion(nil)
                }
            }
        } else {
            print("Invalid URL")
            completion(nil)
        }
    }
    
    func getPhotoData(url: URL, completion: @escaping (Data?) -> ()) {
        CarSearchWorker.getData(url: url) { data, error in
            if let data = data {
                completion(data)
            } else {
                completion(nil)
            }
        }
    }
}
