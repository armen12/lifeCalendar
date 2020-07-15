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
        self.setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.setRepo()
        self.view.addSubview(activityIndicator)
    }
    override func viewDidLayoutSubviews() {
        activityIndicator.center = view.center
        let index = self.presenter.presentingData?.first(where: {$0.isCurrentDate})
        let indexPath = IndexPath(item: index?.date ?? 0, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)

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
    @IBAction func segmentController(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
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
        guard let item = presenter.presentingData?[indexPath.row] else { return UICollectionViewCell()}
       return collectionView.dequeueReusableCell(withType: CalendarCollectionViewCell.self, for: indexPath).setupCell(item: item)
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
        self.hideActivityIndicator()
        self.descriptuinLabel.text = presenter.leftHourse
        self.collectionView.reloadData()
        
    }
    
}
