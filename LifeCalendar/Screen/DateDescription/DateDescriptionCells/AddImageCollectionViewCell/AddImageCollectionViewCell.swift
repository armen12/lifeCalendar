//
//  AddImageCollectionViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 28.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class AddImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCell(image: UIImage) -> Self{
        self.dateImage.image = image
        return self
    }

}
