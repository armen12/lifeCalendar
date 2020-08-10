//
//  DiaryPresenter.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 04.08.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
protocol DiaryViewControllerInterface: class {
    func loading()
    func success()
    func failure(error: String)
    func addPaggination()


}
protocol DiaryPresenterProtocol {
    init(view: DiaryViewControllerInterface, realmBuilder: RealmBuilderProtocol, router: RouterProtocol)
    func setUp()
}
class DiaryPresenter: DiaryPresenterProtocol{
    weak var view: DiaryViewControllerInterface?
    var realmBuilder: RealmBuilderProtocol?
    var router: RouterProtocol!
    var years: [DateInterval]
    var months: [DateInterval]
    var days: [DateInterval]
    var tempDays: [DateInterval]
    var tempWeeks: [DateInterval]
    required init(view: DiaryViewControllerInterface, realmBuilder: RealmBuilderProtocol, router: RouterProtocol) {
        self.view = view
        self.realmBuilder = realmBuilder
        self.router = router
        self.years = []
        self.months = []
        self.days = []
        self.tempDays = []
        self.tempWeeks = []
    }
    
    func setUp() {
        self.view?.loading()
        self.loadYears()
        self.loadMonths()
        self.loadDays()
        self.view?.success()
    }
    func loadYears(){
        if  let db = realmBuilder?.getData(ofType: Year.self)  {
            db.forEach({
                years.append(self.getCurrentDate(date: $0, dateType: .year))
            })
        }else{
            self.view?.failure(error: "Fail Years")
        }
    }

    func loadMonths(){
        if  let db =  realmBuilder?.getData(ofType: Month.self){
            db.forEach({
                months.append(self.getCurrentDate(date: $0, dateType: .month))
            })
            
        }else{
            self.view?.failure(error: "Fail Month")
            
        }
    }
    func loadDays(){
        if  let db  = realmBuilder?.getData(ofType: Day.self){
            self.tempDays = db
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
    
    func getPaginationDays(pagination: Int, isFirst: Bool, isTopScroll: Bool?){
           if isFirst{
               let myBirthday = UserDefaults.standard.object(forKey: "myBirthday") as! Date
               let daysOfLifeIndex = Date().days(from: myBirthday)
               guard let currentDayIndex = self.tempDays.first(where: {$0.index == daysOfLifeIndex})?.index else {return}
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
               self.view?.addPaggination()
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
               self.view?.addPaggination()
               
           }else{
               print("Error")
           }
       }

}
