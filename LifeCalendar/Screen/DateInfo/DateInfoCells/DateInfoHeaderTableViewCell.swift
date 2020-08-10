//
//  DateInfoHeaderTableViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 03.08.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class DateInfoHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var emotionImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCell(item: DateInterval) -> Self{
        self.titleLabel.text = item.titel
        self.emotionImage.image = UIImage(named: item.emotion)
        return self
    }
    
}
