//
//  SceneDelegate.swift
//  Swift News
//
//  Created by Chenguo Yan on 2020-10-04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationViewController = UINavigationController()
        window?.rootViewController = navigationViewController
        navigationViewController.pushViewController(MainViewController(), animated: true)
        window?.makeKeyAndVisible()
        
    }
}

