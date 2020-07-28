//
//  Year.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
import RealmSwift
protocol DateTypse: Object, DateInterval {
    
}

@objc protocol DateInterval {
    @objc dynamic var date: Date {get set}
    @objc dynamic var index: Int {get set}
    @objc dynamic var titel: String { get set }
    @objc dynamic var diaryEntry: String{ get set }
    @objc dynamic var media: String { get set }
    @objc dynamic var emotion: Emotion.RawValue { get set}
    @objc dynamic var isCurrentindex: Bool{ get set }
    @objc dynamic var isActive: Bool { get set }
    
}

enum Emotion: String {
    case fire = "fire"
    case rock = "rock"
    case neutral = "neutral"
    case dead = "dead"
    case heart = "heart"
    case empty = "empty"
    
}

class Year: Object, DateInterval {
    @objc  dynamic var date: Date = Date()

    @objc  dynamic var index: Int = 0
    @objc dynamic var titel: String = ""
    @objc  dynamic var diaryEntry: String = ""
    @objc  dynamic var media: String = ""
    @objc dynamic var emotion: Emotion.RawValue = "empty"
    @objc dynamic var isCurrentindex: Bool = false
    @objc dynamic var isActive: Bool = false
    
    convenience init(date: Date, index: Int, titel: String, diaryEntry: String, media: String,emotion: Emotion, isCurrentindex: Bool, isActive: Bool ) {
        self.init()
        self.date = date
        self.index = index
        self.titel = titel
        self.diaryEntry = diaryEntry
        self.media = media
        self.emotion = emotion.rawValue
        self.isCurrentindex = isCurrentindex
        self.isActive = isActive
        
    }
    
    
    override class func primaryKey() -> String? {
        return "index"
    }
}
