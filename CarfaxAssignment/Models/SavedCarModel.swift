//
//  SavedCarModel.swift
//  CarfaxAssignment
//
//  Created by Mbah Fonong on 10/1/19.
//  Copyright © 2019 Mbah Fonong. All rights reserved.
//

import Foundation
import RealmSwift

class SavedListingModel: Object {
    @objc dynamic var id: String = ""
    
    @objc dynamic var model: String = ""
    
    @objc dynamic var year: String = ""
    
    @objc dynamic var make: String = ""
    
    @objc dynamic var trim: String = ""
    
    @objc dynamic var phone: String = ""
    
    @objc dynamic var price: String = ""
    
    @objc dynamic var mileage: String = ""
    
    @objc dynamic var location: String = ""
    
    @objc dynamic var carImage: Data? = nil
}
