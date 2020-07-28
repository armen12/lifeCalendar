//
//  CalendarBuilder.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//
import Foundation
import DateToolsSwift

enum DateType{
    case year
    case month
    case week
    case day
}

protocol CalendarBuilderProtocol {
    //    func setupCalendar(myBirthday: String, myDeath: Str)
    func setupCalendar(myBirthday: Date, myDeath: Date)
    func getTimeInterval(type: DateType) -> (first: String, second: String)
}
extension CalendarBuilderProtocol{
}

class CalendarBuilder: CalendarBuilderProtocol{
    
    func getTimeInterval(type: DateType) -> (first: String, second: String) {
        let date = UserDefaults.standard.object(forKey: "myDeath") as! Date
        let timeInterval = date.timeIntervalSince(Date())
        switch type {
        case .year:
            return (first:self.stringFromTimeInterval(interval: timeInterval), second: "\(date.years(from: Date())) years")
        case .month:
            return (first:self.stringFromTimeInterval(interval: timeInterval), second: "\(date.months(from: Date())) months")
        case .week:
            return (first:self.stringFromTimeInterval(interval: timeInterval), second: "\(date.weeks(from: Date())) weeks")
        case .day:
            return (first:self.stringFromTimeInterval(interval: timeInterval), second: "\(date.days(from: Date())) days")
        }
    }
    
    func setupCalendar(myBirthday: Date, myDeath: Date) {
        let defaults = UserDefaults.standard
        defaults.set(myBirthday, forKey: "myBirthday")
        defaults.set(myDeath, forKey: "myDeath")
        self.setupYears(myBirthday: myBirthday, myDeath: myDeath)
        self.setupMonth(myBirthday: myBirthday, myDeath: myDeath)
        self.setupWeeks(myBirthday: myBirthday, myDeath: myDeath)
        self.setupDays(myBirthday: myBirthday, myDeath: myDeath)
        defaults.set(false, forKey: "isFirstTime")
        
        
        
    }
    private func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return "\(hours)h : \(minutes)m : \(seconds)s"
    }
    
    private func setupYears(myBirthday: Date, myDeath: Date){
        var arrayOfyears = [Year]()
        let myDeath = UserDefaults.standard.object(forKey: "myDeath") as! Date
        let myBirthday = UserDefaults.standard.object(forKey: "myBirthday") as! Date
        var index = 0
         for year in  myBirthday.year..<(myDeath.year+1){
            let date = Calendar.current.date(byAdding: .year, value: index, to: myBirthday)!
            arrayOfyears.append(Year(date: date, index: year, titel: "", diaryEntry: "", media: "", emotion: Emotion.empty , isCurrentindex: false, isActive: false))
            index+=1
        }
        RealmBuilder.shared.saveDate(date: arrayOfyears)
    }
    
    private  func setupMonth(myBirthday: Date, myDeath: Date){
        let weeksOfLife = myDeath.months(from: myBirthday)
        var arrayOfMonth = [Month]()
        for month in 0..<(weeksOfLife){
            let date = Calendar.current.date(byAdding: .month, value: month, to: myBirthday)!
            arrayOfMonth.append(Month(date: date, index: month, titel: "", diaryEntry: "", media: "", emotion: Emotion.empty , isCurrentindex: false, isActive: false))
        }
        RealmBuilder.shared.saveDate(date: arrayOfMonth)
        
    }
    
    private func setupWeeks(myBirthday: Date, myDeath: Date){
        let weeksOfLife = myDeath.weeks(from: myBirthday)
        var arrayOfWeeks = [Week]()
        for week in 0..<(weeksOfLife){
            let date = Calendar.current.date(byAdding: .weekOfYear, value: week, to: myBirthday)!
            arrayOfWeeks.append(Week(date: date, index: week, titel: "", diaryEntry: "", media: "", emotion: Emotion.empty , isCurrentindex: false, isActive: false))        }
        RealmBuilder.shared.saveDate(date: arrayOfWeeks)
    
    }
    
    private func setupDays(myBirthday: Date, myDeath: Date){
        let daysOfLife = myDeath.days(from: myBirthday)
        var arrayOfDays = [Day]()
        for day in 0..<(daysOfLife){
            let date =  Calendar.current.date(byAdding: .day, value: day, to: myBirthday)!
            arrayOfDays.append(Day(date: date, index: day, titel: "", diaryEntry: "", media: "", emotion: Emotion.empty , isCurrentindex: false, isActive: false))
        }
        RealmBuilder.shared.saveDate(date: arrayOfDays)
    }
    
}
