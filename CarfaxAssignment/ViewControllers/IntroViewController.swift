//
//  IntroViewController.swift
//  CarfaxAssignment
//
//  Created by Mbah Fonong on 8/8/19.
//  Copyright © 2019 Mbah Fonong. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var mainAnimationView: UIView!
    
    @IBOutlet weak var foxLogoImageView: UIImageView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var introStackView: UIStackView!
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    
    static let nibName: String = "IntroViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.foxLogoImageView.image = #imageLiteral(resourceName: "carfaxLogo")
        self.welcomeLabel.text = CommonStrings.welcome
        self.introStackView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.stackViewBottomConstraint.constant = -self.introStackView.frame.height
        self.animateIntro()
    }


    func animateIntro() {
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.introStackView.isHidden = false
            self.stackViewBottomConstraint.constant = self.view.frame.height / 3
            self.view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.9, animations: {
                self.mainAnimationView.alpha = 0
            }, completion: { _ in
                CarSearchViewController.window = nil
            })
        }
    }
}
