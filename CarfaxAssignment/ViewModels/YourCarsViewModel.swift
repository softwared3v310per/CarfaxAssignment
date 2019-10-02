//
//  YourCarsViewModel.swift
//  CarfaxAssignment
//
//  Created by Mbah Fonong on 10/2/19.
//  Copyright © 2019 Mbah Fonong. All rights reserved.
//

import Foundation
import RealmSwift

class YourCarsViewModel {
    
    var realm: Realm? {
        do {
            let realm = try Realm()
            return realm
        } catch let error {
            print("Error in creating realm: \(error)")
            return nil
        }
    }
    
    func fetchListings() -> Results<SavedListingModel>? {
        guard let realm = self.realm else {
            return nil
        }
        
        let listings = realm.objects(SavedListingModel.self)
        return listings
    }
    
    func deleteListing(id: String) {
        guard let realm = self.realm else { print("Cannot get realm"); return }
        if let listing = realm.objects(SavedListingModel.self).filter("id = '\(id)'").first {
            do {
                try realm.write {
                    realm.delete(listing)
                }
            } catch let error as NSError {
                print("Error in deleting: \(error)")
            }
        } else {
            print("No object found with id \(id)")
        }
    }
}
