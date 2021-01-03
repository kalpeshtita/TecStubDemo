//
//  AppDelegate.swift
//  TecStubDemo
//
//  Created by Apple on 02/01/21.
//  Copyright © 2021 Tita. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /* Create ui-view-controller instance*/
        let dogListView = DogListRouter.createDogListView()

        /* Initiating instance of ui-navigation-controller with view-controller */
        let navigationController = UINavigationController()
        navigationController.viewControllers = [dogListView]

        /* Setting up the root view-controller as ui-navigation-controller */
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()


        return true
    }
}

