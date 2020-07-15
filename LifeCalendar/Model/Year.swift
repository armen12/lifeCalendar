//
//  Year.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
import RealmSwift
@objc protocol DateInterval {
    @objc dynamic var date: Int {get set}
    @objc dynamic var titel: String { get set }
    @objc dynamic var diaryEntry: String{ get set }
    @objc dynamic var media: Data { get set }
    @objc dynamic var emotion: Emotion.RawValue { get set}
    @objc dynamic var isCurrentDate: Bool{ get set }
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
    @objc  dynamic var date: Int = 0
    @objc dynamic var titel: String = ""
    @objc  dynamic var diaryEntry: String = ""
    @objc  dynamic var media: Data = Data()
    @objc dynamic var emotion: Emotion.RawValue = "empty"
    @objc dynamic var isCurrentDate: Bool = false
    @objc dynamic var isActive: Bool = false
    
    convenience init(date: Int, titel: String, diaryEntry: String, media: Data,emotion: Emotion, isCurrentDate: Bool, isActive: Bool ) {
        self.init()
        self.date = date
        self.titel = titel
        self.diaryEntry = diaryEntry
        self.media = media
        self.emotion = emotion.rawValue
        self.isCurrentDate = isCurrentDate
        self.isActive = isActive
        
    }
    
    
    override class func primaryKey() -> String? {
        return "date"
    }
}
