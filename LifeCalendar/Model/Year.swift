//
//  Year.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
import RealmSwift
protocol TimeInterval {
     dynamic var titel: String { get set }

}
protocol isRealmObject: Object{
    
}
enum Emotion {
    case fire
    case rock
    case neutral
    case dead
    case heart
    case empty

}

class Year: Object, TimeInterval {
     dynamic var year: String = ""
    dynamic var titel: String = ""
     dynamic var diaryEntry: String = ""
     dynamic var media: Data = Data()
    dynamic var emotion: Emotion = .empty
     dynamic var isCurrentYear: Bool = false
     dynamic var isActive: Bool = false
    
    convenience init(year: String, titel: String, diaryEntry: String, media: Data,emotion: Emotion, isCurrentYear: Bool, isActive: Bool ) {
        self.init()
        self.year = year
        self.titel = titel
        self.diaryEntry = diaryEntry
        self.media = media
        self.emotion = emotion
        self.isCurrentYear = isCurrentYear
        self.isActive = isActive
        
    }
    
    
    override class func primaryKey() -> String? {
        return "year"
    }
}
