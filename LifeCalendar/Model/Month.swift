//
//  Month.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
import RealmSwift

class Month: Object, TimeInterval {
    @objc  dynamic var month: String = ""
    @objc dynamic var titel: String = ""
    @objc dynamic var diaryEntry: String = ""
    @objc dynamic var media: Data = Data()
    dynamic var emotion: Emotion = .empty
    @objc dynamic var isCurrentMonth: Bool = false
    @objc dynamic var isActive: Bool = false
    
    convenience init(month: String, titel: String, diaryEntry: String, media: Data,emotion: Emotion, isCurrentMonth: Bool, isActive: Bool ) {
         self.init()
         self.month = month
         self.titel = titel
         self.diaryEntry = diaryEntry
         self.media = media
         self.emotion = emotion
         self.isCurrentMonth = isCurrentMonth
         self.isActive = isActive
         
     }
    
    override class func primaryKey() -> String? {
        return "month"
    }
}
