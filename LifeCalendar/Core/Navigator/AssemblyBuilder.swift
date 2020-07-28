//
//  AssemblyBuilder.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

protocol  AssemblyBuilderProtocol {
    func createMainView(router: RouterProtocol) -> UIViewController
    func createCalendarController(router: Router) -> UIViewController
    func createDateDescriptionController(router: Router, item: DateInterval) -> UIViewController
}
class AssemblyBuilder: AssemblyBuilderProtocol{
    
    func createMainView(router: RouterProtocol) -> UIViewController {
        let view = RegistrationViewController()
        let calendarBuilder = CalendarBuilder()
        let presenter = RegistrationPresenter(view: view, router: router, calendarBuilder: calendarBuilder)
        view.presenter = presenter
        return view
    }
    
    func createCalendarController(router: Router) -> UIViewController{
        let view = CalendarViewController()
        let realmDB = RealmBuilder()
        let calendarBuilder = CalendarBuilder()
        
        let presenter = CalendarPresenter(view: view, realmDB: realmDB, router: router, calendareBuilder: calendarBuilder)
        view.presenter = presenter
        return view
    }
    
    func createDateDescriptionController(router: Router, item: DateInterval) -> UIViewController {
        let view = DateDescriptionViewController()
        let realmDB = RealmBuilder()
        let presenter = DateDescriptionPresenter(view: view, realmDB: realmDB, router: router, item: item)
        view.presenter = presenter
        return view
    }
}
