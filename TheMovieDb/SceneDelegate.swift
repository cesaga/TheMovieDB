//
//  SceneDelegate.swift
//  TheMovieDb
//
//  Created by Cesar Castillo on 17-05-22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = setupRootViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func setupRootViewController() -> UIViewController {
        let movieListViewController = SceneFactory.makeMovieListViewController()
        let navigationController = UINavigationController(rootViewController: movieListViewController)
        
        return navigationController
    }
}

