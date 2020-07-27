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
    var indexing = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customeView.layer.borderWidth = 1
        self.customeView.layer.borderColor = UIColor.gray.cgColor
        self.customeView.layer.cornerRadius = 8
        self.customeView.layer.masksToBounds = true
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.emotionImageView.image = UIImage(named: "dead")
    }
    func setupCell(item: DateInterval) -> Self{
        indexing = item.index
        if item.isCurrentindex{
            self.customeView.layer.borderColor = UIColor.red.cgColor
            self.customeView.layer.borderWidth = 4
        }else if item.isActive{
            self.customeView.layer.borderColor = UIColor.blue.cgColor
            self.customeView.layer.borderWidth = 4
        }else{
            self.customeView.layer.borderWidth = 1
            self.customeView.layer.borderColor = UIColor.gray.cgColor
        }
        
        self.emotionImageView.image = UIImage(named: "rock")
        
        
        return self
    }
    
}
