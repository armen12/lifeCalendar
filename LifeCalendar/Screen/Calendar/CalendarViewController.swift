//
//  CalendarViewController.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit
import DateToolsSwift

class CalendarViewController: UIViewController {
    var presenter: CalendarPresenter!
    
    
    @IBOutlet weak var descriptuinLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var activityIndicator = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpCollectionView()
        self.view.addSubview(activityIndicator)
    }
    override func viewDidLayoutSubviews() {
        activityIndicator.center = view.center
    }
    private func hideActivityIndicator(){
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
    }
    
    func setup(){
        let yearofBirth = 1996
        let month = 02
        let day = 7
        let lifeInYears = yearofBirth + 80
        
        
        let myBirthday = Date(dateString: "\(day)-\(month)-\(yearofBirth)", format: "dd-MM-yyyy", timeZone: .autoupdatingCurrent)
        let myDeath = Date(dateString: "\(day)-\(month)-\(lifeInYears)", format: "dd-MM-yyyy", timeZone: .autoupdatingCurrent)
        //        CalendarBuilder(myBirthday: myBirthday, myDeath: myDeath)
    }
    private func setUpCollectionView(){
        //        self.tableView.register(GitRepoTableViewCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    @IBAction func segmentController(_ sender: UISegmentedControl) {
        switch sender.numberOfSegments {
        case 0:
            self.presenter.getDays()
        case 1:
            self.presenter.getWeeks()
        case 2:
            self.presenter.getMonths()
        case 3:
            self.presenter.getYears()
            
            
        default:
            self.presenter.getDays()
            
        }
    }
}
extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter.presentingData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
    
}

extension CalendarViewController: CalendarInterface{
    func success() {
        self.hideActivityIndicator()
        self.collectionView.reloadData()
    }
    
    func loading() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func failure(error: String) {
        self.hideActivityIndicator()
        self.alert(message: error)
    }
    func changeTimeInterval(){
        self.collectionView.reloadData()
        
    }
    
}
