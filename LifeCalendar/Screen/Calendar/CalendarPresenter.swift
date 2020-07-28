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
    func addPaggination()
}
protocol  CalendarPresenterProtocol: class {
    init(view: CalendarInterface, realmDB: RealmBuilderProtocol, router: RouterProtocol, calendareBuilder: CalendarBuilderProtocol)
    func setRepo()
    func selectDate(date: DateInterval)
    
    
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
    var tempDays: [DateInterval]
    var tempWeeks: [DateInterval]
    
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
        self.tempDays = []
        self.tempWeeks = []
    }
    
    func setRepo() {
        self.getDate(dataType: .day)
        
    }
    
    func selectDate(date: DateInterval) {
        self.router.showDateDescriptionController(item: date)
    }
    func getDate(dataType: DateType){
        self.view?.loading()
        switch dataType {
        case .year:
            self.years = []
            self.loadYears()
            self.presentingData = self.years
            self.view?.success()
        case .month:
            self.tempWeeks = []
            self.months = []
            self.loadMonths()
            self.presentingData = self.months
            self.view?.success()
        case .week:
            self.weeks = []
            self.loadWeeks()
            self.presentingData = self.weeks
            self.view?.success()
        case .day:
            self.tempDays = []
            self.days = []
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
                years.append(self.getCurrentDate(date: $0, dateType: .year))
            })
        }else{
            self.view?.failure(error: "Fail Years")
        }
    }
    
    func loadMonths(){
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
            self.tempWeeks = db
            let s = self.calendareBuilder?.getTimeInterval(type: .week)
            leftHourse = "Left: \(s?.second ?? "") \nor \n\(s?.first ?? "") "
            getPaginationWeeks(pagination: 100, isFirst: true, isTopScroll: nil)
        }else{
            self.view?.failure(error: "Fail Week")
            
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
    
     func getCurrentDate(date: DateInterval, dateType: DateType) -> DateInterval{
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
