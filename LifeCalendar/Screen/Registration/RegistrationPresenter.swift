//
//  RegistrationPresenter.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 15.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
protocol RegistrationInterface: class{
    func showContent()
}
protocol RegistrationPresenterProtocol {
    init(view:RegistrationInterface, router: RouterProtocol, calendarBuilder: CalendarBuilderProtocol)
    func setupView()
    func goButtonTap()
}

class RegistrationPresenter: RegistrationPresenterProtocol{

    
    weak var view: RegistrationInterface?
    var router: RouterProtocol!
    var calendarBuilder: CalendarBuilderProtocol?
    required init(view:RegistrationInterface,  router: RouterProtocol, calendarBuilder: CalendarBuilderProtocol) {
        self.router = router
        self.calendarBuilder = calendarBuilder
        self.view = view
    }
    
    func setupView() {
         let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isFirstTime")
        let yearofBirth = 1996
        let month = 02
        let day = 7
        let lifeInYears = yearofBirth + 80
        
        
        let myBirthday = Date(dateString: "\(day)-\(month)-\(yearofBirth)", format: "dd-MM-yyyy", timeZone: .autoupdatingCurrent)
        let myDeath = Date(dateString: "\(day)-\(month)-\(lifeInYears)", format: "dd-MM-yyyy", timeZone: .autoupdatingCurrent)
        self.calendarBuilder?.setupCalendar(myBirthday: myBirthday, myDeath: myDeath)
            self.view?.showContent()
    }
    func goButtonTap(){
        self.router.showCalendarController()
    }
}
