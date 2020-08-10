//
//  YearCollectionViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 05.08.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class YearCollectionViewCell: UICollectionViewCell {
    
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
        dateLabel.text = "Year \(item.index)"
        if item.emotion == "empty"{
            self.emotionImage.isHidden = true
        }else{
            emotionImage.image = UIImage(named: item.emotion)
        }
        if item.titel == ""{
            dateLabel.textColor = UIColor.mainNotActive
            self.isFullImage.alpha = 0
        }else{
            dateLabel.textColor = UIColor.mainActive
            self.isFullImage.alpha = 1
        }
        return self
    }
    
}
