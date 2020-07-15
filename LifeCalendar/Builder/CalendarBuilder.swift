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
        
        for year in  myBirthday.year..<(myDeath.year+1){
            print(year)
            if year < Date().year{
                arrayOfyears.append(Year(date: year, titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty , isCurrentDate: false, isActive: false))
            }else if year == Date().year{
                arrayOfyears.append(Year(date: year, titel: "", diaryEntry: "", media: Data(),  emotion: Emotion.empty, isCurrentDate: true, isActive: true))
            }else{
                arrayOfyears.append(Year(date: year, titel: "", diaryEntry: "", media: Data(),  emotion: Emotion.empty, isCurrentDate: false, isActive: true))
            }
        }
        RealmBuilder.shared.saveDate(date: arrayOfyears)
//        print(arrayOfyears)
    }
    
    private  func setupMonth(myBirthday: Date, myDeath: Date){
        let weeksOfLife = myDeath.months(from: myBirthday)
        let weeksToCurrentDate = Date().months(from: myBirthday)
        var arrayOfMonth = [Month]()
        for month in 0..<(weeksOfLife+1){
            if month < weeksToCurrentDate{
                arrayOfMonth.append(Month(date: month, titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentDate: false, isActive: false))
                
            }else if month == weeksToCurrentDate{
                arrayOfMonth.append(Month(date: month, titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentDate: true, isActive: true))
            }else{
                arrayOfMonth.append(Month(date: month, titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentDate: false, isActive: true))
            }
        }
        RealmBuilder.shared.saveDate(date: arrayOfMonth)

//        print(arrayOfMonth)
    }
    
    private func setupWeeks(myBirthday: Date, myDeath: Date){
        let weeksOfLife = myDeath.weeks(from: myBirthday)
        let weeksToCurrentDate = Date().weeks(from: myBirthday)
        var arrayOfWeeks = [Week]()
        for week in 0..<(weeksOfLife+1){
            if week < weeksToCurrentDate{
                arrayOfWeeks.append(Week(date: week, titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentDate: false, isActive: false))
                
            }else if week == weeksToCurrentDate{
                arrayOfWeeks.append(Week(date: week, titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentDate: true, isActive: true))
            }else{
                arrayOfWeeks.append(Week(date: week, titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentDate: false, isActive: true))
            }
        }
        RealmBuilder.shared.saveDate(date: arrayOfWeeks)

//        print(arrayOfWeeks)
    }
    
    private func setupDays(myBirthday: Date, myDeath: Date){
        let daysOfLife = myDeath.days(from: myBirthday)
        let daysToCurrentDate = Date().days(from: myBirthday)
        var arrayOfDays = [Day]()
        for day in 0..<(daysOfLife+1){
            if day < daysToCurrentDate{
                arrayOfDays.append(Day(date: day, titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentDate: false, isActive: false))
                
            }else if day == daysToCurrentDate{
                arrayOfDays.append(Day(date: day, titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentDate: true, isActive: true))
            }else{
                arrayOfDays.append(Day(date: day, titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentDate: false, isActive: true))
            }
        }
        RealmBuilder.shared.saveDate(date: arrayOfDays)

//        print(arrayOfDays)
    }
    
}
