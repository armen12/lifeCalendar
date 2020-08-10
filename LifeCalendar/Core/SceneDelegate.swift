//
//  SceneDelegate.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 13.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navController = UINavigationController()
        let assemblyBuilder = AssemblyBuilder()
        let router = Router(navigationController: navController, assemblyBuilder: assemblyBuilder)
         let defaults = UserDefaults.standard
        let isFirstTime = defaults.object(forKey: "isFirstTime") as? Bool ?? true
        isFirstTime ?  router.rootViewController(): router.createTabBarController()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene){
    }

    func sceneDidBecomeActive(_ scene: UIScene){
    }

    func sceneWillResignActive(_ scene: UIScene){
    }

    func sceneWillEnterForeground(_ scene: UIScene){
    }

    func sceneDidEnterBackground(_ scene: UIScene){
    }
}

