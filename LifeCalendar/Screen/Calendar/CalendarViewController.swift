//
//  CalendarViewController.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit
import JGProgressHUD

class CalendarViewController: UIViewController {
    var presenter: CalendarPresenter!
    
    @IBOutlet weak var descriptuinLabel: UILabel!
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let hud = JGProgressHUD(style: .dark)
    
    private var dateType: DateType = .day
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.addShadow(UIColor(red: 0, green: 0, blue: 0, alpha: 0.15), radius: 20)
        self.setUpCollectionView()
        self.presenter.getDate(dataType: dateType)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    private func hideActivityIndicator(){
        hud.dismiss(animated: false)
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
            self.dateType = .day
            self.presenter.getDate(dataType: .day)
        case 1:
            self.dateType = .week
            self.presenter.getDate(dataType: .week)
        case 2:
            self.dateType = .month
            self.presenter.getDate(dataType: .month)
        case 3:
            self.dateType = .year
            self.presenter.getDate(dataType: .year)
        default:
            self.dateType = .year
            self.presenter.getDate(dataType: .year)
        }
    }
}
extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch dateType {
        case .day:
            if indexPath.row == self.presenter.presentingData.count - 1 {
                self.presenter.getPaginationDays(pagination: 100, isFirst: false, isTopScroll: false)
            }
        case .week:
            if indexPath.row == self.presenter.presentingData.count - 1 {
                self.presenter.getPaginationWeeks(pagination: 100, isFirst: false, isTopScroll: false)
            }
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.presentingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = presenter.presentingData[indexPath.row]
        return collectionView.dequeueReusableCell(withType: CalendarCollectionViewCell.self, for: indexPath).setupCell(item: item)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.selectDate(date: self.presenter.presentingData[indexPath.row])
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
    func addPaggination() {
        DispatchQueue.main.async {
            self.descriptuinLabel.text = self.presenter.leftHourse
            self.collectionView.reloadData()
        }
    }
    
    func success() {
        DispatchQueue.main.async {
            defer{
                self.view.loadingIndicator(false)
            }
            self.descriptuinLabel.text = self.presenter.leftHourse
            self.collectionView.reloadData()
            self.collectionView.performBatchUpdates(nil) { ( _) in
                self.scrollToCurrentDate()
            }
        }
        
    }
    
    func loading() {
        DispatchQueue.main.async {
            self.view.loadingIndicator(true)
        }
    }
    
    func failure(error: String) {
        self.hideActivityIndicator()
        self.alert(message: error)
    }
}

extension CalendarViewController{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch dateType {
        case .day:
            if (scrollView.contentOffset.y <= 1){
                scrollView.contentOffset.y = 25
                self.presenter.getPaginationDays(pagination: 100, isFirst: false, isTopScroll: true)
            }
            
        case .week:
            if (scrollView.contentOffset.y <= 1){
                scrollView.contentOffset.y = 25
                self.presenter.getPaginationWeeks(pagination: 100, isFirst: false, isTopScroll: true)
            }
        default:
            break
        }
    }
    
}
