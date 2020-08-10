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
    func createTabBarController()
    func showCalendarController()
    func showDateDescriptionController(item: DateInterval)
    func showDateInfoController(item: DateInterval)
    func showDiaryController()
    func popScreen()
    func popToRoot()
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
    
    func createTabBarController(){
        if let navigationController = navigationController{
             guard let calendarVC = assemblyBuilder?.createCalendarController(router: self) else {return}
            calendarVC.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "homenon-active"), selectedImage: UIImage(named: "homeactive"))
            guard let diaryVC = assemblyBuilder?.createDiaryController(router: self) else {return}
            diaryVC.tabBarItem = UITabBarItem(title: "Diary", image: UIImage(named: "diarynon-active"), selectedImage: UIImage(named: "diaryactive"))
            let tabBarController = UITabBarController()
            tabBarController.tabBar.tintColor = UIColor.black
            tabBarController.viewControllers = [calendarVC, diaryVC]
            navigationController.pushViewController(tabBarController, animated: true)
        }
    }
    
    func showDateDescriptionController(item: DateInterval) {
        if let navigationController = navigationController{
            guard let detailsVC = assemblyBuilder?.createDateDescriptionController(router: self, item: item) else {return}
            navigationController.pushViewController(detailsVC, animated: true)
        }
    }
    func showDateInfoController(item: DateInterval) {
        if let navigationController = navigationController{
            guard let detailsVC = assemblyBuilder?.createDateInfoController(router: self, item: item) else {return}
            navigationController.pushViewController(detailsVC, animated: true)
        }
    }
    
    func showDiaryController() {
        if let navigationController = navigationController{
            guard let detailsVC = assemblyBuilder?.createDiaryController(router: self) else {return}
            navigationController.pushViewController(detailsVC, animated: true)
        }
    }
    func popScreen() {
        if let navigationController = navigationController{
            navigationController.popViewController(animated: true)
        }
    }
    func popToRoot(){
        if let navigationController = navigationController{
            navigationController.popToRootViewController(animated: true)
        }
    }
}
