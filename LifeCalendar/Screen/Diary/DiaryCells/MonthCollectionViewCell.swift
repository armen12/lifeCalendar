//
//  MonthCollectionViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 05.08.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emotionImage: UIImageView!
    @IBOutlet weak var isFullImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customView.layer.borderWidth = 1
        self.customView.layer.borderColor = UIColor.gray.cgColor
        self.customView.layer.cornerRadius = 8
        self.customView.layer.masksToBounds = true
    }
    
    func setupCell(item: DateInterval) -> Self{
        dateLabel.text = "Month \(item.index)"
        if item.emotion == "empty"{
            self.emotionImage.isHidden = true
        }else{
            emotionImage.image = UIImage(named: item.emotion)
        }
        if item.titel == ""{
            isFullImage.alpha = 0
            dateLabel.textColor = UIColor.mainNotActive
        }else{
            isFullImage.alpha = 1
            dateLabel.textColor = UIColor.mainActive
        }
        return self
    }
    
}
