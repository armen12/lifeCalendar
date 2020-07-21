//
//  CalendarPresenter.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation

protocol CalendarInterface: class{
    func loading()
    func success()
    func failure(error: String)
    func changeTimeIntervalDays()
    func changeTimeIntervalOther()
}
protocol  CalendarPresenterProtocol: class {
    init(view: CalendarInterface, realmDB: RealmBuilderProtocol, router: RouterProtocol, calendareBuilder: CalendarBuilderProtocol)
    func setRepo()
    var presentingData: [DateInterval] {get set}
    
}
class CalendarPresenter: CalendarPresenterProtocol{
    var presentingData: [DateInterval]
    var years: [DateInterval]
    var months: [DateInterval]
    var weeks: [DateInterval]
    var days: [DateInterval]
    var leftHourse: String?
    let calendareBuilder: CalendarBuilderProtocol?
    weak var view: CalendarInterface?
    var realmDB: RealmBuilderProtocol?
    var router: RouterProtocol!
    var currentDayIndex: Int
    var tempDays: [DateInterval]
    
    required init(view: CalendarInterface, realmDB: RealmBuilderProtocol, router: RouterProtocol, calendareBuilder: CalendarBuilderProtocol ) {
        self.view = view
        self.realmDB = realmDB
        self.router = router
        self.calendareBuilder = calendareBuilder
        self.years = []
        self.months = []
        self.weeks = []
        self.days = []
        self.presentingData = []
        self.currentDayIndex = 0
        self.tempDays = []
    }
    
    func setRepo() {
        self.view?.loading()
//        self.loadDays()
        self.getDate(dataType: .day)
        
    }
    func getDate(dataType: DateType){
        switch dataType {
        case .year:
            self.loadYears()
            self.presentingData = self.years
            self.view?.changeTimeIntervalOther()
        case .month:
            self.loadMonths()
            self.presentingData = self.months
            self.view?.changeTimeIntervalOther()
        case .week:
            self.loadWeeks()
            self.presentingData = self.weeks
            self.view?.changeTimeIntervalOther()
        case .day:
            self.loadDays()
            self.presentingData = self.days
             self.view?.success()
        }
    }
    
    func loadYears(){
        if  let db = realmDB?.getData(ofType: Year.self)  {
            let s = self.calendareBuilder?.getTimeInterval(type: .year)
            leftHourse = "Left: \(s?.second ?? "") \n" + "or \n" + "\(s?.first ?? "")"
            db.forEach({
                years.append(self.getCurrentDate(date: $0, dateType: .month))
            })
        }else{
            self.view?.failure(error: "Fail Years")
        }
    }
    
    func loadMonths(){
        self.view?.loading()
        if  let db =  realmDB?.getData(ofType: Month.self){
            let s = self.calendareBuilder?.getTimeInterval(type: .month)
            leftHourse = "Left: \(s?.second ?? "") \nor \n\(s?.first ?? "")"
            db.forEach({
                months.append(self.getCurrentDate(date: $0, dateType: .month))
            })
            
        }else{
            self.view?.failure(error: "Fail Month")
            
        }
    }
    
    
    func loadWeeks(){
        if  let db = realmDB?.getData(ofType: Week.self){
            let s = self.calendareBuilder?.getTimeInterval(type: .week)
            leftHourse = "Left: \(s?.second ?? "") \nor \n\(s?.first ?? "") "
            db.forEach({
                weeks.append(self.getCurrentDate(date: $0, dateType: .week))
            })
            self.getDate(dataType: .week)
        }else{
            self.view?.failure(error: "Fail Week")
            
        }
    }
    func getPaginationDays(pagination: Int, isFirst: Bool, isTopScroll: Bool?){
        if isFirst{
            let myBirthday = UserDefaults.standard.object(forKey: "myBirthday") as! Date
            let daysOfLifeIndex = Date().days(from: myBirthday)
            guard let currentDayIndex = self.tempDays.first(where: {$0.index == daysOfLifeIndex})?.index else {return}
            self.currentDayIndex = currentDayIndex
            let chunc = Array(self.tempDays[currentDayIndex-pagination...currentDayIndex+pagination])
            chunc.forEach({
                days.append(self.getCurrentDate(date: $0, dateType: .day))
            })
        }else{
            if isTopScroll ?? false{
                self.insertNewDays(pagination: pagination)
            }else{
                self.appendNewDays(pagination: pagination)
            }
        }
    }
    func appendNewDays(pagination:Int){
        let tempIndex = days.last!.index + pagination
        if self.tempDays.indices.contains(tempIndex) {
            let chunc = Array(self.tempDays[days.last!.index+1...tempIndex])
            chunc.forEach({
                days.append(self.getCurrentDate(date: $0, dateType: .day))
            })
             self.presentingData = days
            self.view?.changeTimeIntervalDays()
        }else{
            print("Error")
        }
    }
    func insertNewDays(pagination: Int){
        let tempIndex = days.first!.index - pagination
        if self.tempDays.indices.contains(tempIndex) {
            let chunc = Array(self.tempDays[tempIndex...days.first!.index-1])
            chunc.forEach({
                days.insert(self.getCurrentDate(date: $0, dateType: .day), at: 0)
            })
             self.presentingData = days
            self.view?.changeTimeIntervalDays()
        }else{
            print("Error")
        }
    }
    
    func loadDays(){
        
        if  let db  = realmDB?.getData(ofType: Day.self){
            self.tempDays = db
            let s = self.calendareBuilder?.getTimeInterval(type: .day)
            leftHourse = "Left: \(s?.second ?? "") \nor \n\(s?.first ?? "") "
            getPaginationDays(pagination: 100, isFirst: true, isTopScroll: nil)
        }else{
            self.view?.failure(error: "Fail Day")
            
        }
    }
    private func getCurrentDate(date: DateInterval, dateType: DateType) -> DateInterval{
        let s = date.date.format(with: "dd-MM-yyyy", locale: .current)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = .current
        let dateWithTimeZone = dateFormatter.date(from: s)
        switch dateType {
            
        case .year:
            if dateWithTimeZone?.year == Date().year{
                date.isCurrentindex = true
            }else{
                return date
            }
            
        case .month:
            if dateWithTimeZone?.year == Date().year {
                if dateWithTimeZone?.month ==  Date().month{
                    date.isCurrentindex = true
                }else{
                    date.isActive = true
                }
            }else{
                return date
            }
            
        case .week:
            if dateWithTimeZone?.year == Date().year && dateWithTimeZone?.month ==  Date().month {
                date.isCurrentindex = true
            }else{
                return date
            }
            
        case .day:
            if dateWithTimeZone?.year == Date().year && dateWithTimeZone?.month ==  Date().month{
                if dateWithTimeZone?.day ==  Date().day{
                    date.isCurrentindex = true
                }else{
                    date.isActive = true
                }
            }else{
                return date
            }
            
        }
        return date
    }
}
