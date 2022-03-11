//
//  SceneDelegate.swift
//  TestWork
//
//  Created by Polina on 09.03.2022.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    @available(iOS 13.0, *)
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let navController = UINavigationController(rootViewController: GalleryImagesViewController())
        
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}

