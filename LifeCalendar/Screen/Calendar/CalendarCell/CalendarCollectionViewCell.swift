//
//  CalendarCollectionViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 14.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var customeView: UIView!
    @IBOutlet weak var emotionImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCell(item: TimeInterval) -> Self{
        return self
    }

}
