//
//  CarSearchViewModel.swift
//  CarfaxAssignment
//
//  Created by Mbah Fonong on 8/7/19.
//  Copyright © 2019 Mbah Fonong. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class CarSearchViewModel {
    var photoCache: NSCache = NSCache<NSString, UIImage>()
    
    var realm: Realm? {
        do {
            let realm = try Realm()
            return realm
        } catch let error {
            print("Error in creating realm: \(error)")
            return nil
        }
    }
    
    func getCarListings(completion: @escaping ([CarModel]?) -> ())  {
        if let url = URL(string: CommonStrings.carfaxURL) {
            CarSearchWorker.getDataAF(url: url) { (data, error) in
                if let data = data, let carModels = CarSearchWorker.parseData(data: data) {
                    completion(carModels.listings)
                } else {
                    print("Error getting data: \(String(describing: error))")
                    completion(nil)
                }
            }
        } else {
            print(CommonStrings.invalid)
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
    
    func saveListing(model: CarModel, imageData: Data) {
        guard let realm = self.realm else { print("Cannot get realm"); return }
        let savedCar = SavedListingModel()
        savedCar.price = "\(model.listPrice)"
        savedCar.location = "\(model.dealer.city), \(model.dealer.state)"
        savedCar.mileage = "\(model.mileage)"
        savedCar.model = model.model
        savedCar.id = model.id
        savedCar.trim = model.trim
        savedCar.phone = model.dealer.phone
        savedCar.make = model.make
        savedCar.year = "\(model.year)"
        savedCar.carImage = imageData
        do {
            try realm.write {
                realm.add(savedCar)
            }
        } catch let error as NSError {
            print("Error in saving to realm:\(error)")
        }
    }
}
