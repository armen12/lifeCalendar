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
    init(view: CalendarInterface, realmDB: RealmBuilderProtocol, router: RouterProtocol, calendareBuilder: CalendarBuilderProtocol)
    func setRepo()
    var presentingData: [DateInterval]? {get set}
    
}
class CalendarPresenter: CalendarPresenterProtocol{
    var presentingData: [DateInterval]?
    var leftHourse: String?
    let calendareBuilder: CalendarBuilderProtocol?
    weak var view: CalendarInterface?
    var realmDB: RealmBuilderProtocol?
    var router: RouterProtocol!
    
    required init(view: CalendarInterface, realmDB: RealmBuilderProtocol, router: RouterProtocol, calendareBuilder: CalendarBuilderProtocol ) {
        self.view = view
        self.realmDB = realmDB
        self.router = router
        self.calendareBuilder = calendareBuilder
    }
    
    func setRepo() {
        self.view?.loading()
        self.getYears()
    }
    func getYears(){
        if  let db = RealmBuilder.shared.getData(ofType: Year.self)  {
            let s = self.calendareBuilder?.getTimeInterval(type: .year)
            leftHourse = "Left: \(s?.second ?? "") \n" + "or \n" + "\(s?.first ?? "")"
            print(db)
            presentingData = db
            
            self.view?.changeTimeInterval()
        }else{
            self.view?.failure(error: "Fail Years")
            
        }
        
    }
    
    func getMonths(){
        self.view?.loading()
        if  let db =  RealmBuilder.shared.getData(ofType: Month.self){
            let s = self.calendareBuilder?.getTimeInterval(type: .month)
            leftHourse = "Left: \(s?.second ?? "") \nor \n\(s?.first ?? "") "
            presentingData = db
            self.view?.changeTimeInterval()
        }else{
            self.view?.failure(error: "Fail Month")
            
        }
    }
    
    func getWeeks(){
        self.view?.loading()
        if  let db =   RealmBuilder.shared.getData(ofType: Week.self){
            let s = self.calendareBuilder?.getTimeInterval(type: .week)
            leftHourse = "Left: \(s?.second ?? "") \nor \n\(s?.first ?? "") "
            presentingData = db
            self.view?.changeTimeInterval()
        }else{
            self.view?.failure(error: "Fail Week")
            
        }
    }
    
    func getDays(){
        self.view?.loading()
        if  let db  = RealmBuilder.shared.getData(ofType: Day.self){
            let s = self.calendareBuilder?.getTimeInterval(type: .day)
            leftHourse = "Left: \(s?.second ?? "") \nor \n\(s?.first ?? "") "
            presentingData = db
            self.view?.changeTimeInterval()
        }else{
            self.view?.failure(error: "Fail Day")
            
        }
    }
}
