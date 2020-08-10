//
//  DateInfoDescriptionTableViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 03.08.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class DateInfoDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCell(item: DateInterval) -> Self{
        self.descriptionLabel.text = item.diaryEntry
        return self
    }
    
}
