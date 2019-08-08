//
//  CarSearchViewController.swift
//  CarfaxAssignment
//
//  Created by Mbah Fonong on 8/7/19.
//  Copyright © 2019 Mbah Fonong. All rights reserved.
//

import UIKit

class CarSearchViewController: UIViewController {
    
    @IBOutlet weak var carTableView: UITableView!
    
    var viewModel: CarSearchViewModel = CarSearchViewModel()
    static var window: UIWindow?
    var carListings: [CarModel]? {
        didSet {
            self.carTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.carTableView.dataSource = self
        self.carTableView.delegate = self
        self.carTableView.register(UINib(nibName: CarSearchTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: CarSearchTableViewCell.nibName)
        self.viewModel.getCarListings { carModels in
            DispatchQueue.main.async {
                self.carListings = carModels
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupAnimation()
    }
    
    func setupAnimation() {
        let introVC = IntroViewController(nibName: IntroViewController.nibName, bundle: nil)
        
        CarSearchViewController.window = UIWindow(frame: UIScreen.main.bounds)
         if let window = CarSearchViewController.window {
            window.rootViewController = introVC
            window.makeKeyAndVisible()
        }
    }
}

extension CarSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let carlistings = self.carListings else { return 0 }
        return carlistings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarSearchTableViewCell.nibName, for: indexPath) as? CarSearchTableViewCell, let carListings = self.carListings else {
            return UITableViewCell()
        }
        
        cell.configure(model: carListings[indexPath.row])
        if let photo = self.viewModel.photoCache.object(forKey: NSString(string: carListings[indexPath.row].id)) {
            cell.carImageView.image = photo
        } else {
            self.viewModel.getCarImage(imageURL: carListings[indexPath.row].images?.firstPhoto.medium, id: carListings[indexPath.row].id) { photo in
                DispatchQueue.main.async {
                    cell.carImageView.image = photo
                }
            }
        }
        
        return cell
    }
}

extension CarSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
