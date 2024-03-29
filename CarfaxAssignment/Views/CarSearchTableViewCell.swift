//
//  CarSearchTableViewCell.swift
//  CarfaxAssignment
//
//  Created by Mbah Fonong on 8/7/19.
//  Copyright © 2019 Mbah Fonong. All rights reserved.
//
import RealmSwift
import UIKit

protocol CarSearchTableViewCellDelegate: class {
    func makeCall(url: URL)
}

class CarSearchTableViewCell: UITableViewCell {
    
    weak var delegate: CarSearchTableViewCellDelegate?

    @IBOutlet weak var carImageView: UIImageView!
    
    @IBOutlet weak var carModelLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var mileageLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var callButton: UIButton! {
        didSet {
            callButton.addTarget(self, action: #selector(self.makeCall), for: .touchUpInside)
        }
    }
    
    static let nibName: String = "CarSearchTableViewCell"
    
    func configure(model: CarModel) {
        let trim: String = model.trim == "\(CommonStrings.unspecified)" ? "" : model.trim
        self.carModelLabel.text = "\(model.year) \(model.make) \(model.model) \(trim)"
        self.priceLabel.text = "$\(model.listPrice)"
        self.mileageLabel.text = "\(model.mileage) \(CommonStrings.mileage)"
        self.locationLabel.text = "\(model.dealer.city), \(model.dealer.state)"
        self.callButton.setTitle("\(CommonStrings.call): \(model.dealer.phone)", for: .normal)
    }
    
    func configure(model: SavedListingModel) {
        if let imageData = model.carImage {
            self.carImageView.image = UIImage(data: imageData)
        }
        let trim: String = model.trim == "\(CommonStrings.unspecified)" ? "" : model.trim
        self.carModelLabel.text = "\(model.year) \(model.make) \(model.model) \(trim)"
        self.priceLabel.text = "$\(model.price)"
        self.mileageLabel.text = "\(model.mileage) \(CommonStrings.mileage)"
        self.locationLabel.text = "\(model.location)"
        self.callButton.setTitle("\(CommonStrings.call): \(model.phone)", for: .normal)
    }
    
    @objc func makeCall() {
        guard let phoneNum = self.callButton.currentTitle?.components(separatedBy: " ").last else { return }
        if let url = URL(string: "tel://\(phoneNum)"), UIApplication.shared.canOpenURL(url) {
            self.delegate?.makeCall(url: url)
        }
    }
}
