//
//  FeelingTableViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 28.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit
protocol FeelingTableViewCellProtocol: class{
    func deadFeelingAction(_ sender: FeelingTableViewCell)
    func neutralFeelingAction(_ sender: FeelingTableViewCell)
    func heartFeelingAction(_ sender: FeelingTableViewCell)
    func rockFeelingAction(_ sender: FeelingTableViewCell)
    func fireFeelingAction(_ sender: FeelingTableViewCell)
}

class FeelingTableViewCell: UITableViewCell {
    @IBOutlet weak var deadButtonOutlet: UIButton!
    @IBOutlet weak var neutralButtonOutlet: UIButton!
    @IBOutlet weak var heartButtonOutlet: UIButton!
    @IBOutlet weak var rockButtonOutlet: UIButton!
    @IBOutlet weak var fireButtonOutlet: UIButton!
    
    weak var delegate: FeelingTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.deadButtonOutlet.layer.cornerRadius = 8
        self.deadButtonOutlet.layer.borderWidth = 1
        self.deadButtonOutlet.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        
        self.neutralButtonOutlet.layer.cornerRadius = 8
        self.neutralButtonOutlet.layer.borderWidth = 1
        self.neutralButtonOutlet.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        
        self.heartButtonOutlet.layer.cornerRadius = 8
        self.heartButtonOutlet.layer.borderWidth = 1
        self.heartButtonOutlet.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        
        self.rockButtonOutlet.layer.cornerRadius = 8
        self.rockButtonOutlet.layer.borderWidth = 1
        self.rockButtonOutlet.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        
        self.fireButtonOutlet.layer.cornerRadius = 8
        self.fireButtonOutlet.layer.borderWidth = 1
        self.fireButtonOutlet.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
    }
    
    func setupCell(delegate: FeelingTableViewCellProtocol) -> Self{
        self.delegate = delegate
        return self
    }
    func setBorderColor(){
         self.deadButtonOutlet.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
         self.neutralButtonOutlet.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
         self.heartButtonOutlet.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
         self.rockButtonOutlet.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
         self.fireButtonOutlet.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
    }
    
    @IBAction func deadFeelingAction(_ sender: UIButton) {
        self.setBorderColor()
        self.deadButtonOutlet.layer.borderColor = UIColor(red: 0.391, green: 0.561, blue: 0.958, alpha: 1).cgColor
        delegate?.deadFeelingAction(self)
    }
    @IBAction func neutralFeelingAction(_ sender: UIButton) {
         self.setBorderColor()
        self.neutralButtonOutlet.layer.borderColor = UIColor(red: 0.391, green: 0.561, blue: 0.958, alpha: 1).cgColor
        delegate?.neutralFeelingAction(self)
    }
    @IBAction func heartFeelingAction(_ sender: UIButton) {
         self.setBorderColor()
        self.heartButtonOutlet.layer.borderColor = UIColor(red: 0.391, green: 0.561, blue: 0.958, alpha: 1).cgColor
        delegate?.heartFeelingAction(self)
    }
    @IBAction func rockFeelingAction(_ sender: UIButton) {
         self.setBorderColor()
        self.rockButtonOutlet.layer.borderColor = UIColor(red: 0.391, green: 0.561, blue: 0.958, alpha: 1).cgColor
        delegate?.rockFeelingAction(self)
    }
    @IBAction func fireFeelingAction(_ sender: UIButton) {
         self.setBorderColor()
        self.fireButtonOutlet.layer.borderColor = UIColor(red: 0.391, green: 0.561, blue: 0.958, alpha: 1).cgColor
        delegate?.fireFeelingAction(self)
    }
}
