//
//  CarSearchViewModel.swift
//  CarfaxAssignment
//
//  Created by Mbah Fonong on 8/7/19.
//  Copyright © 2019 Mbah Fonong. All rights reserved.
//

import Foundation
import UIKit

class CarSearchViewModel {
    var photoCache: NSCache = NSCache<NSString, UIImage>()
    
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
    
    func getCarImage(imageURL: String?, id: String, completion: @escaping (UIImage) -> ()) {
        if let imageURL = imageURL, let url = URL(string: imageURL) {
            self.getPhotoData(url: url) { photoData in
                if let photoData = photoData, let photo = UIImage(data: photoData) {
                    self.photoCache.setObject(photo, forKey: NSString(string: id))
                    completion(photo)
                } else {
                    completion(#imageLiteral(resourceName: "image-not-available"))
                }
            }
        } else {
            completion( #imageLiteral(resourceName: "image-not-available"))
        }
    }
}
