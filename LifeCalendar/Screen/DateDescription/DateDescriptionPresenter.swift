//
//  DateDescriptionPresenter.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 28.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
protocol DateDescriptionInterface: class{
    func success()
    func error()
}
protocol DateDescriptionPresenterProtocol {
    init(view: DateDescriptionInterface, realmDB: RealmBuilderProtocol, router: RouterProtocol, item: DateInterval)
    func setUp()
    func save()
    func cancel()
}
class DateDescriptionPresenter: DateDescriptionPresenterProtocol{
    weak var view: DateDescriptionInterface?
    var realmDB: RealmBuilderProtocol?
    var router: RouterProtocol!
    var item: DateInterval

    required init(view: DateDescriptionInterface, realmDB: RealmBuilderProtocol, router: RouterProtocol, item: DateInterval) {
        self.view = view
        self.router = router
        self.realmDB = realmDB
        self.item = item
    }
    func setUp() {
        self.view?.success()
    }
    func save() {
        self.realmDB?.updateDate(date: item)
        self.router.popScreen()
    }
    func cancel() {
        self.router.popScreen()
    }
    
    
}
