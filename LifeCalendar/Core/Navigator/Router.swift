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
//    func showDetailViewController(item: GitRepoModel?)
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
                   guard let mainVC = assemblyBuilder?.createCalendarController(router: self) else {return}
                   navigationController.viewControllers = [mainVC]
               }
    }
}
