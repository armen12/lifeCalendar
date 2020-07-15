//
//  CalendarPresenter.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
import RealmSwift

protocol CalendarInterface: class{
    func loading()
    func success()
    func failure(error: String)
    func changeTimeInterval()
}
protocol  CalendarPresenterProtocol: class {
    init(view: CalendarInterface, realmDB: RealmBuilderProtocol)
    func setRepo()
//    var days: [Day]? {get set}
//    var weeks: [Week]? {get set}
//    var months: [Month]? {get set}
//    var years: [Year]? {get set}
    var presentingData: [TimeInterval]? {get set}
    
}
class CalendarPresenter: CalendarPresenterProtocol{
    var presentingData: [TimeInterval]?
    
    weak var view: CalendarInterface?
    var realmDB: RealmBuilderProtocol?
    required init(view: CalendarInterface, realmDB: RealmBuilderProtocol) {
        self.view = view
        self.realmDB = realmDB
    }
    
    func setRepo() {
        self.view?.loading()
    }
    func getYears(){
        if  let db = RealmBuilder.shared.getData(ofType: Year.self)  {
            presentingData = db
            self.view?.changeTimeInterval()
        }else{
            self.view?.failure(error: "Fail Years")

        }
        
    }
    
    func getMonths(){
        if  let db =  RealmBuilder.shared.getData(ofType: Month.self){
            presentingData = db
            self.view?.changeTimeInterval()
        }else{
            self.view?.failure(error: "Fail Month")

        }
    }
    
    func getWeeks(){
        if  let db =   RealmBuilder.shared.getData(ofType: Week.self){
            presentingData = db
            self.view?.changeTimeInterval()
        }else{
            self.view?.failure(error: "Fail Week")

        }
    }
    
    func getDays(){
        if  let db  = RealmBuilder.shared.getData(ofType: Day.self){
            presentingData = db
            self.view?.changeTimeInterval()
        }else{
            self.view?.failure(error: "Fail Day")

        }
    }
    
}
