//
//  DateInfoPresenter.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 03.08.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
protocol DateInfoInterface: class {
    func succsess()
}
protocol DateInfoProtocol {
    init(view: DateInfoInterface, router: RouterProtocol, item: DateInterval)
       func setUp()
}
class DateInfoPresenter: DateInfoProtocol{
    var router: RouterProtocol!
    weak var view: DateInfoInterface?
    var item: DateInterval
    required init(view: DateInfoInterface, router: RouterProtocol, item: DateInterval) {
        self.view = view
        self.item = item
        self.router = router
    }
    
    func setUp() {
        self.view?.succsess()
    }
    func cancel() {
        self.router.popScreen()
    }
    
    func edit(){
        self.router.showDateDescriptionController(item: self.item)
    }
}
