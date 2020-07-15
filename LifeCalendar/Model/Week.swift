//
//  Week.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
import RealmSwift

class Week: Object, TimeInterval {
   @objc dynamic var week: String = ""
   @objc dynamic var titel: String = ""
   @objc dynamic var diaryEntry: String = ""
   @objc dynamic var media: Data = Data()
   dynamic var emotion: Emotion = .empty
   @objc dynamic var isCurrentWeek: Bool = false
   @objc dynamic var isActive: Bool = false

    convenience init(week: String, titel: String, diaryEntry: String, media: Data,emotion: Emotion, isCurrentWeek: Bool, isActive: Bool ) {
        self.init()
        self.week = week
        self.titel = titel
        self.diaryEntry = diaryEntry
        self.media = media
        self.emotion = emotion
        self.isCurrentWeek = isCurrentWeek
        self.isActive = isActive
        
    }
    override class func primaryKey() -> String? {
        return "week"
    }
}
