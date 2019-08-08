//
//  CarListingModel.swift
//  CarfaxAssignment
//
//  Created by Mbah Fonong on 8/7/19.
//  Copyright © 2019 Mbah Fonong. All rights reserved.
//

import Foundation

struct CarListingModel: Decodable {
    let listings: [CarModel]
    
    private enum CodingKeys: String, CodingKey {
        case listings
    }
}

struct CarModel: Decodable {
    let make: String
    let model: String
    let mileage: Int
    let listPrice: Int
    let year: Int
    let trim: String
    let id: String
    let images: Images?
    let dealer: Dealer
    
    private enum CodingKeys: String, CodingKey {
        case make
        case model
        case mileage
        case listPrice
        case year
        case trim
        case id
        case images
        case dealer
    }
}

struct Dealer: Decodable {
    
    let city: String
    let state: String
    let phone: String
    
    private enum CodingKeys: String, CodingKey {
        case city
        case state
        case phone
    }
}

struct Images: Decodable {
    
    let firstPhoto: Photos
    
    private enum CodingKeys: String, CodingKey {
        case firstPhoto
    }
}

struct Photos: Decodable {
    
    let medium: String
    
    private enum CodingKeys: String, CodingKey {
        case medium
    }
}
