//
//  SceneDelegate.swift
//  MovieLand
//
//  Created by Patka on 01/03/2023.
//

import UIKit
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        let tabBarController = UITabBarController()
        
        let searchNavigationController = UINavigationController()
        let searchTabRouter = TabRouter(navigationController: searchNavigationController)
        
        // launch screen
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "LaunchScreenViewController")
        
        let searchViewController = SearchViewController(tabRouter: searchTabRouter)
        searchNavigationController.viewControllers = [searchViewController]
        
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: Constants.magnifyingGlassImage, selectedImage: Constants.magnifyingGlassImage)
//
        let testController = UIViewController()
        testController.view.backgroundColor = .gray
        
        let top250MoviesViewController = Top250MoviesViewController(tabRouter: searchTabRouter)
        top250MoviesViewController.tabBarItem = UITabBarItem(title: "Featured", image: Constants.featuredImageHeart, selectedImage: Constants.featuredImageHeart)
        
        tabBarController.viewControllers = [searchNavigationController, top250MoviesViewController, testController]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    
}


