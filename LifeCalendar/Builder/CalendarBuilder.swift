//
//  CalendarBuilder.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//
import Foundation
import DateToolsSwift

class CalendarBuilder{
    init(myBirthday: Date,  myDeath: Date ) {
//        if firsTime
        self.setupCalendar(myBirthday: myBirthday, myDeath: myDeath)
    }
    func setupCalendar(myBirthday: Date, myDeath: Date){
        self.setupYears(myBirthday: myBirthday, myDeath: myDeath)
        self.setupMonth(myBirthday: myBirthday, myDeath: myDeath)
        self.setupWeeks(myBirthday: myBirthday, myDeath: myDeath)
        self.setupDays(myBirthday: myBirthday, myDeath: myDeath)
    }
    func setupYears(myBirthday: Date, myDeath: Date){
        var arrayOfyears = [Year]()
        for year in  myBirthday.year..<(myDeath.year+1){
            print(year)
            if year < Date().year{
                arrayOfyears.append(Year(year: String(year), titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty , isCurrentYear: false, isActive: false))
            }else if year == Date().year{
                arrayOfyears.append(Year(year: String(year), titel: "", diaryEntry: "", media: Data(),  emotion: Emotion.empty, isCurrentYear: true, isActive: true))
            }else{
                arrayOfyears.append(Year(year: String(year), titel: "", diaryEntry: "", media: Data(),  emotion: Emotion.empty, isCurrentYear: false, isActive: true))
            }
        }
        RealmBuilder.shared.saveYear(year: arrayOfyears)
        print(arrayOfyears)
    }
    
    func setupMonth(myBirthday: Date, myDeath: Date){
        let weeksOfLife = myDeath.months(from: myBirthday)
        let weeksToCurrentDate = Date().months(from: myBirthday)
        var arrayOfMonth = [Month]()
        for month in 0..<(weeksOfLife+1){
            if month < weeksToCurrentDate{
                arrayOfMonth.append(Month(month: String(month), titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentMonth: false, isActive: false))
                
            }else if month == weeksToCurrentDate{
                arrayOfMonth.append(Month(month: String(month), titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentMonth: true, isActive: true))
            }else{
                arrayOfMonth.append(Month(month: String(month), titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentMonth: false, isActive: true))
            }
        }
        print(arrayOfMonth)
    }
    
    func setupWeeks(myBirthday: Date, myDeath: Date){
        let weeksOfLife = myDeath.weeks(from: myBirthday)
        let weeksToCurrentDate = Date().weeks(from: myBirthday)
        var arrayOfWeeks = [Week]()
        for week in 0..<(weeksOfLife+1){
            if week < weeksToCurrentDate{
                arrayOfWeeks.append(Week(week: String(week), titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentWeek: false, isActive: false))
                
            }else if week == weeksToCurrentDate{
                arrayOfWeeks.append(Week(week: String(week), titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentWeek: true, isActive: true))
            }else{
                arrayOfWeeks.append(Week(week: String(week), titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentWeek: false, isActive: true))
            }
        }
        print(arrayOfWeeks)
    }
    
    func setupDays(myBirthday: Date, myDeath: Date){
        let daysOfLife = myDeath.days(from: myBirthday)
        let daysToCurrentDate = Date().days(from: myBirthday)
        var arrayOfDays = [Day]()
        for day in 0..<(daysOfLife+1){
            if day < daysToCurrentDate{
                arrayOfDays.append(Day(day: String(day), titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentDay: false, isActive: false))
                
            }else if day == daysToCurrentDate{
                arrayOfDays.append(Day(day: String(day), titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentDay: true, isActive: true))
            }else{
                arrayOfDays.append(Day(day: String(day), titel: "", diaryEntry: "", media: Data(), emotion: Emotion.empty, isCurrentDay: false, isActive: true))
            }
        }
        print(arrayOfDays)
    }
    
}
