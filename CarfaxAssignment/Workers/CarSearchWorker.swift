//
//  CarSearchWorker.swift
//  CarfaxAssignment
//
//  Created by Mbah Fonong on 8/7/19.
//  Copyright © 2019 Mbah Fonong. All rights reserved.
//

import Foundation

class CarSearchWorker {
    static func getData(url: URL, completion: @escaping (Data?, Error?) -> ()) {
        let config: URLSessionConfiguration = .default
        let session: URLSession = URLSession(configuration: config)
        session.dataTask(with: url) { data, _, error in
            if error == nil {
                completion(data, nil)
            } else {
                completion(nil, error)
            }
        }.resume()
    }
    
    static func parseData(data: Data) -> CarListingModel? {
        do {
            let carListings = try JSONDecoder().decode(CarListingModel.self, from: data)
            return carListings
        } catch let error {
            print("Error in parsing \(error)")
            return nil
        }
    }
}
