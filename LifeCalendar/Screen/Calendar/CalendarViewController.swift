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
    private var dateType: DateType = .day
    private var isFirsTime = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.setRepo()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .red
        self.view.addSubview(activityIndicator)
    }
    private func hideActivityIndicator(){
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
    }
    
    private func setUpCollectionView(){
        self.collectionView.register(CalendarCollectionViewCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    private func scrollToCurrentDate(){
        print("scrollToCurrentDate")
            let some = self.presenter.presentingData.firstIndex(where: {$0.isCurrentindex})
        print(some)
//        let indexOfA = self.presenter.presentingData.firstIndex(where: "a")
        let middle = (self.presenter.presentingData.count - 1) / 2
        let indexPath = IndexPath(item: middle, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        self.isFirsTime = false
    }
    @IBAction func segmentController(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            dateType = .day
            self.presenter.getDate(dataType: .day)
        case 1:
            dateType = .week
            self.presenter.getDate(dataType: .week)
        case 2:
            dateType = .month
            self.presenter.getDate(dataType: .month)
        case 3:
            dateType = .year
            self.presenter.getDate(dataType: .year)
        default:
            dateType = .day
            self.presenter.getDate(dataType: .day)
            
            
        }
    }
}
extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == self.presenter.presentingData.count - 1 {  //numberofitem count
            print("updateNextSet()")
            self.presenter.getPaginationDays(pagination: 100, isFirst: false, isTopScroll: false)
        }else if indexPath.row == 0 {
            print("-------()")
//            if !self.isFirsTime{
//                 self.presenter.getPaginationDays(pagination: 100, isFirst: false, isTopScroll: true)
//                
//            }
            
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.presenter.presentingData.count)
        return self.presenter.presentingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = presenter.presentingData[indexPath.row]
        return collectionView.dequeueReusableCell(withType: CalendarCollectionViewCell.self, for: indexPath).setupCell(item: item)
    }
    
    
    
}

extension CalendarViewController: CalendarInterface{
    func success() {
        self.descriptuinLabel.text = presenter.leftHourse
        self.hideActivityIndicator()
        self.collectionView.reloadData()
        self.collectionView.performBatchUpdates(nil) { ( _) in
            self.scrollToCurrentDate()
        }
    }
    
    func loading() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        self.view.isUserInteractionEnabled = false
    }
    
    func failure(error: String) {
        self.hideActivityIndicator()
        self.alert(message: error)
    }
    func changeTimeIntervalDays(){
        self.descriptuinLabel.text = presenter.leftHourse
        self.collectionView.reloadData()
        self.hideActivityIndicator()
        
    }
    func changeTimeIntervalOther(){
        self.descriptuinLabel.text = presenter.leftHourse
        self.hideActivityIndicator()
        self.collectionView.reloadData()
//        self.collectionView.performBatchUpdates(nil) { ( _) in
//            self.scrollToCurrentDate()
//        }
    }
    
}
