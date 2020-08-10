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
    @IBOutlet weak var isFullImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customeView.layer.borderWidth = 1
        self.customeView.layer.borderColor = UIColor.gray.cgColor
        self.customeView.layer.cornerRadius = 8
        self.customeView.layer.masksToBounds = true
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    func setupCell(item: DateInterval) -> Self{
        if item.isCurrentindex{
            self.customeView.layer.borderColor = UIColor.red.cgColor
            self.customeView.layer.borderWidth = 1
        }else if item.isActive{
            self.customeView.layer.borderColor = UIColor(red: 0.391, green: 0.561, blue: 0.958, alpha: 1).cgColor
            self.customeView.layer.borderWidth = 1
        }else{
            self.customeView.layer.borderWidth = 1
            self.customeView.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        }
        if item.titel == ""{
            self.isFullImageView.alpha = 0
        }else{
            self.isFullImageView.alpha = 1
        }
        self.emotionImageView.image = UIImage(named: item.emotion)
        
        
        return self
    }
    
}
