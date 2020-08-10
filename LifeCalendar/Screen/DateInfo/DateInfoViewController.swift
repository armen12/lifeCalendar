//
//  DateInfoViewController.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 03.08.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class DateInfoViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var presenter: DateInfoPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.setUp()
    }
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(NavigationTableViewCell.self)
        self.tableView.register(DateInfoHeaderTableViewCell.self)
        self.tableView.register(DateInfoDescriptionTableViewCell.self)
        self.tableView.register(DateInfoImagesTableViewCell.self)
    }
}
extension DateInfoViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withType: NavigationTableViewCell.self, for: indexPath).setupCell(delegate: self, type: .edit, item: self.presenter.item)
        case 1:
            return tableView.dequeueReusableCell(withType: DateInfoHeaderTableViewCell.self, for: indexPath).setupCell(item: self.presenter.item)
        case 2:
            return tableView.dequeueReusableCell(withType: DateInfoDescriptionTableViewCell.self, for: indexPath).setupCell(item: self.presenter.item)
        case 3:
            return tableView.dequeueReusableCell(withType: DateInfoImagesTableViewCell.self, for: indexPath).setupCell(item: self.presenter.item)
        default:
            return UITableViewCell()
        }
    }
    
}
extension DateInfoViewController: NavigationTableViewCellProtocol{
    func cancelAction(_ sender: NavigationTableViewCell) {
        self.presenter.cancel()
    }
    
    func saveActoin(_ sender: NavigationTableViewCell) {
        self.presenter.edit()
    }
    
    
}
extension DateInfoViewController: DateInfoInterface{
    func succsess() {
        self.setupTableView()
    }
}
