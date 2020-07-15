//
//  RegistrationViewController.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 15.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    var presenter: RegistrationPresenter!
    
    @IBOutlet weak var goButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goButtonOutlet.isHidden = true
        self.presenter.setupView()
    }
    
    @IBAction func nextScreenAction(_ sender: Any) {
        self.presenter.goButtonTap()
    }
}

extension RegistrationViewController: RegistrationInterface{
    func showContent() {
        self.goButtonOutlet.isHidden = false
        
    }
}
