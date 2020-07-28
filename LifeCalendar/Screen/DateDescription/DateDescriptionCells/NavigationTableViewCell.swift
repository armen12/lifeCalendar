//
//  NavigationTableViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 27.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit
protocol NavigationTableViewCellProtocol: class{
    func cancelAction(_ sender: NavigationTableViewCell)
    func saveActoin(_ sender: NavigationTableViewCell)
}
class NavigationTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    weak var delegate: NavigationTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    func setupCell(delegate: NavigationTableViewCellProtocol) -> Self{
        self.delegate = delegate
        return self
    }
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.delegate?.cancelAction(self)
    }
    @IBAction func saveButtonAction(_ sender: UIButton) {
        self.delegate?.saveActoin(self)
    }
    
}
