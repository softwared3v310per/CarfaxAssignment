//
//  YourCarsViewController.swift
//  CarfaxAssignment
//
//  Created by Mbah Fonong on 10/1/19.
//  Copyright © 2019 Mbah Fonong. All rights reserved.
//

import RealmSwift
import UIKit

class YourCarsViewController: UIViewController {

    let viewModel: YourCarsViewModel = YourCarsViewModel()
    
    @IBOutlet weak var savedCarsTableView: UITableView!
    
    @IBOutlet weak var noCarsLabel: UILabel! {
        didSet {
            noCarsLabel.text = CommonStrings.noCars
        }
    }
    
    var carListings: Results<SavedListingModel>? {
        didSet {
            self.savedCarsTableView.reloadData()
            self.savedCarsTableView.isHidden = carListings?.count == 0 || carListings == nil ? true : false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.savedCarsTableView.register(UINib(nibName: CarSearchTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: CarSearchTableViewCell.nibName)
        self.savedCarsTableView.dataSource = self
        self.savedCarsTableView.delegate = self
        self.carListings = self.viewModel.fetchListings()
    }
}

extension YourCarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carListings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarSearchTableViewCell.nibName, for: indexPath) as? CarSearchTableViewCell, let listing = self.carListings?[indexPath.row] else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(model: listing)
        return cell
    }
}

extension YourCarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let id = self.carListings?[indexPath.row].id {
                self.viewModel.deleteListing(id: id)
                self.carListings = self.viewModel.fetchListings()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
