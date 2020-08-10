//
//  NavigationTableViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 27.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit
enum NavigaationType{
    case edit
    case create
}
protocol NavigationTableViewCellProtocol: class{
    func cancelAction(_ sender: NavigationTableViewCell)
    func saveActoin(_ sender: NavigationTableViewCell)
}
class NavigationTableViewCell: UITableViewCell {

    @IBOutlet weak var cancelButtonOutlet: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    weak var delegate: NavigationTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    func setupCell(delegate: NavigationTableViewCellProtocol, type: NavigaationType, item: DateInterval) -> Self{
        switch type {
        case .edit:
            self.cancelButtonOutlet.setTitle("", for: .normal)
            self.cancelButtonOutlet.setImage(UIImage(named: "backButton"), for: .normal)
            
            self.saveButtonOutlet.setTitle("Edit", for: .normal)
        default:
            break
        }
        switch item.self{
        case is Day:
            dateLabel.text = "Day \(item.index)"
        case is Week:
            dateLabel.text = "Week \(item.index)"
        case is Month:
            dateLabel.text = "Month \(item.index)"
        case is Year:
            dateLabel.text = "Year \(item.index)"
        default:
            break
        }
//        self.dateLabel.text = "Day \()"
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
