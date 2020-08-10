//
//  DiaryViewController.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 04.08.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {
    
    @IBOutlet weak var yearCollectionView: UICollectionView!
    @IBOutlet weak var monthCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var presenter: DiaryPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupCollectionView()
        self.presenter.setUp()
    }
    func setupCollectionView(){
        self.yearCollectionView.delegate = self
        self.yearCollectionView.dataSource = self
        self.yearCollectionView.register(YearCollectionViewCell.self)
        
        self.monthCollectionView.delegate = self
        self.monthCollectionView.dataSource = self
        self.monthCollectionView.register(MonthCollectionViewCell.self)
    }
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(DayTableViewCell.self)
    }
    private func scrollToCurrentDay(){
        let indexOfCurrentDay = self.presenter.days.firstIndex(where: {$0.isCurrentindex})
        let indexPath = IndexPath(item: indexOfCurrentDay ?? 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        
    }
    private func scrollToCurrentYear(){
        let indexOfCurrentYear = self.presenter.years.firstIndex(where: {$0.isCurrentindex})
        let indexPathYear = IndexPath(item: indexOfCurrentYear ?? 0, section: 0)
        self.yearCollectionView.scrollToItem(at: indexPathYear, at: .centeredVertically, animated: true)
        
        
    }
    private func scrollTiCurrentMonth(){
        let indexOfCurrentMonth = self.presenter.months.firstIndex(where: {$0.isCurrentindex})
        let indexPathMonth = IndexPath(item: indexOfCurrentMonth ?? 0, section: 0)
        self.monthCollectionView.scrollToItem(at: indexPathMonth, at: .centeredVertically, animated: true)
    }
    
}
extension DiaryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.yearCollectionView:
            return self.presenter.years.count
        case self.monthCollectionView:
            return self.presenter.months.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.yearCollectionView:
            return  self.yearCollectionView.dequeueReusableCell(withType: YearCollectionViewCell.self, for: indexPath).setupCell(item: self.presenter.years[indexPath.row])
        case self.monthCollectionView:
            return self.monthCollectionView.dequeueReusableCell(withType: MonthCollectionViewCell.self, for: indexPath).setupCell(item: self.presenter.months[indexPath.row])
        default:
            return UICollectionViewCell()
        }
    }
}
extension DiaryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.presenter.days.count - 1 {
            self.presenter.getPaginationDays(pagination: 100, isFirst: false, isTopScroll: false)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withType: DayTableViewCell.self, for: indexPath).setupCell(item: presenter.days[indexPath.row])
    }
}
//extension DiaryViewController{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            print("scrollViewDidScroll")
//            if (scrollView.contentOffset.y <= 1){
//            scrollView.contentOffset.y = 25
//            self.presenter.getPaginationDays(pagination: 100, isFirst: false, isTopScroll: true)
//        }
//
//    }
//
//}
extension DiaryViewController: DiaryViewControllerInterface{
    func failure(error: String) {
        self.alert(message: error)
    }
    
    func addPaggination() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loading() {
        self.view.loadingIndicator(true)
    }
    
    func success() {
        DispatchQueue.main.async {
            self.view.loadingIndicator(false)
            self.monthCollectionView.reloadData()
            self.monthCollectionView.performBatchUpdates(nil) { (_) in
                self.scrollTiCurrentMonth()
            }
            self.yearCollectionView.reloadData()
            self.yearCollectionView.performBatchUpdates(nil) { (_) in
                self.scrollToCurrentYear()
            }
            self.tableView.reloadData()
            self.tableView.performBatchUpdates(nil) { (_) in
                self.scrollToCurrentDay()
            }
        }
    }
}
