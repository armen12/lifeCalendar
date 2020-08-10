//
//  DateInfoMediaTableViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 03.08.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class DateInfoMediaTableViewCell: UITableViewCell {

    @IBOutlet weak var dateImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func readImageFromDocs(path: String) -> UIImage? {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documents.appendingPathComponent(path).path
        if FileManager.default.fileExists(atPath: url) {
            return UIImage(contentsOfFile: url)
        } else {
            return nil
        }
    }

    func setupCell(imagePath: String) -> Self{
        self.dateImage.image = self.readImageFromDocs(path: imagePath)
        return self
    }
}
