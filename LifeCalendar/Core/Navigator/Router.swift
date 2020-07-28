//
//  Router.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import Foundation
import UIKit
protocol RouterMainProtocol{
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}
protocol RouterProtocol: RouterMainProtocol{
    func rootViewController()
    func showCalendarController()
    func showDateDescriptionController(item: DateInterval)
    func popScreen()
}
class Router: RouterProtocol{
    
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    var navigationController: UINavigationController?
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    func rootViewController() {
        if let navigationController = navigationController{
            guard let mainVC = assemblyBuilder?.createMainView(router: self) else {return}
            navigationController.viewControllers = [mainVC]
        }
    }
    func showCalendarController(){
        if let navigationController = navigationController{
            guard let calendarVC = assemblyBuilder?.createCalendarController(router: self) else {return}
            navigationController.pushViewController(calendarVC, animated: true)
        }
    }
    func showDateDescriptionController(item: DateInterval) {
        if let navigationController = navigationController{
            guard let detailsVC = assemblyBuilder?.createDateDescriptionController(router: self, item: item) else {return}
            navigationController.pushViewController(detailsVC, animated: true)
        }
    }
    func popScreen() {
        if let navigationController = navigationController{
            navigationController.popViewController(animated: true)
        }
    }
}
