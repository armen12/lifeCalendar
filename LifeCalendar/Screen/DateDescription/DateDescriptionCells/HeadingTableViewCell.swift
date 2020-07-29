//
//  HeadingTableViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 28.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit
protocol HeadingTableViewCellProtocol: class{
    func updateHeading(_ sender: HeadingTableViewCell, text: String?)
}
class HeadingTableViewCell: UITableViewCell {
    @IBOutlet weak var headingTextField: UITextField!
    weak var delegate: HeadingTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.headingTextField.delegate = self
    }
    func setupCell(delegate: HeadingTableViewCellProtocol) -> Self{
        self.delegate = delegate
        return self
    }
}
extension HeadingTableViewCell: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.updateHeading(self, text: textField.text)
    }
}
 
