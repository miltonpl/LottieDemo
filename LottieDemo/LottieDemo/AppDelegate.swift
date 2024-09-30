//
//  AppDelegate.swift
//  LottieDemo
//
//  Created by Milton Palaguachi on 9/14/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
     var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let animationView = LottieAnimationView()
        let viewController = ViewController(
            buildingAnimationModel: .init(name: .remote(.building), animationView: animationView)
        )
        let navigationController = UINavigationController(rootViewController: viewController)
        self.window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

