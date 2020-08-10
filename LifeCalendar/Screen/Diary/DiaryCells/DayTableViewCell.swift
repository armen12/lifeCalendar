//
//  DayTableViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 05.08.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateImage: UIImageView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var isFullImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.customView.layer.borderWidth = 1
        self.customView.layer.borderColor = UIColor.gray.cgColor
        self.customView.layer.cornerRadius = 8
        self.customView.layer.masksToBounds = true
    }
    func setupCell(item: DateInterval) -> Self{
        self.dateLabel.text = "Day \(item.index)"
        self.titleLabel.text = item.titel
        if item.emotion == ""{
            self.dateImage.image = UIImage(named: "plus")
        }else{
            self.dateImage.image = UIImage(named: item.emotion)
        }
        if item.titel == "" {
            dateLabel.textColor = UIColor.mainNotActive
            self.customView.layer.borderColor = UIColor.mainNotActive.cgColor
            isFullImage.alpha = 0
        }else{
            dateLabel.textColor = UIColor.mainActive
            self.customView.layer.borderColor = UIColor.mainActive.cgColor
            isFullImage.alpha = 1
        }
        
        return self
    }
}
