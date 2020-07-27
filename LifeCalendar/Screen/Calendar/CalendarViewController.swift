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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var descriptuinLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //    private var activityIndicator = UIActivityIndicatorView()
    private var dateType: DateType = .day
    private var isFirsTime = true
    var lastContentOffset: CGFloat = 0
    
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
        self.descriptuinLabel.isHidden = false
        self.view.isUserInteractionEnabled = true
    }
    
    private func setUpCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.autoresizingMask = .flexibleHeight
        self.collectionView.register(CalendarCollectionViewCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    private func scrollToCurrentDate(){
        let indexOfCurrentDay = self.presenter.presentingData.firstIndex(where: {$0.isCurrentindex})
        let indexPath = IndexPath(item: indexOfCurrentDay ?? 0, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
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
            dateType = .year
            self.presenter.getDate(dataType: .year)
            
            
        }
    }
}
extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        print(indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if dateType == .day{
            if indexPath.row == self.presenter.presentingData.count - 1 {
                self.presenter.getPaginationDays(pagination: 100, isFirst: false, isTopScroll: false)
            }
            
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
extension CalendarViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: 32, height: 32)
        return cellSize
    }
}
extension CalendarViewController: CalendarInterface{
    func addPagginationDays() {
        self.descriptuinLabel.text = presenter.leftHourse
        self.hideActivityIndicator()
        DispatchQueue.main.async {
        self.collectionView.reloadData()
        }
    }
    
    func success() {
        self.descriptuinLabel.text = presenter.leftHourse
        self.hideActivityIndicator()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.performBatchUpdates(nil) { ( _) in
                self.scrollToCurrentDate()
                
            }
        }
    }
    func loading() {
        self.descriptuinLabel.isHidden = true
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        self.view.isUserInteractionEnabled = false
    }
    
    func failure(error: String) {
        self.hideActivityIndicator()
        self.alert(message: error)
    }
}
extension CalendarViewController{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if dateType == .day{
            if (scrollView.contentOffset.y <= 1){
                scrollView.contentOffset.y = 15
                self.presenter.getPaginationDays(pagination: 100, isFirst: false, isTopScroll: true)
            }
        }
    }
    
}
