//
//  SceneDelegate.swift
//  TeratailToDoSample
//
//  Created by 山田隼也 on 2019/11/28.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UINavigationController(rootViewController: MemoListViewController.instance())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
