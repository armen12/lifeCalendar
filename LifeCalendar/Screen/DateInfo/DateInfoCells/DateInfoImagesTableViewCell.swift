//
//  DateInfoImagesTableViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 03.08.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class DateInfoImagesTableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    var arrayOfImagesUrl: [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTableView()
    }
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(DateInfoMediaTableViewCell.self)
    }
    func setupCell(item: DateInterval) -> Self{
        guard let arr = item.media?.value else {return self}
        self.arrayOfImagesUrl = Array(arr)
        return self
    }
}
extension DateInfoImagesTableViewCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrayOfImagesUrl.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withType: DateInfoMediaTableViewCell.self, for: indexPath).setupCell(imagePath: self.arrayOfImagesUrl[indexPath.row])
    }
    
    
}
