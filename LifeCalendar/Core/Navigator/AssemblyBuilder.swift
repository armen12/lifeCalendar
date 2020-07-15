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
}
class AssemblyBuilder: AssemblyBuilderProtocol{
    func createMainView(router: RouterProtocol) -> UIViewController {
        let view = CalendarViewController()
        let realmDB = RealmBuilder()
        let presenter = CalendarPresenter(view: view, realmDB: realmDB)
        view.presenter = presenter
        return view
    }
}
