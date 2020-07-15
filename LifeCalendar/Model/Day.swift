//
//  Day.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
import RealmSwift
class Day: Object, TimeInterval {
    @objc dynamic var day: String = ""
    @objc dynamic var titel: String = ""
    @objc dynamic var diaryEntry: String = ""
    @objc dynamic var media: Data = Data()
    dynamic var emotion: Emotion = .empty
    @objc dynamic var isCurrentDay: Bool = false
    @objc dynamic var isActive: Bool = false
    
    convenience init(day: String, titel: String, diaryEntry: String, media: Data,emotion: Emotion, isCurrentDay: Bool, isActive: Bool ) {
        self.init()
        self.day = day
        self.titel = titel
        self.diaryEntry = diaryEntry
        self.media = media
        self.emotion = emotion
        self.isCurrentDay = isCurrentDay
        self.isActive = isActive
        
    }
    override class func primaryKey() -> String? {
        return "day"
    }
}
