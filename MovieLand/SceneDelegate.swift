//
//  SceneDelegate.swift
//  MovieLand
//
//  Created by Patka on 01/03/2023.
//

import UIKit
import IQKeyboardManagerSwift
import SDWebImage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { _ in
            SDImageCache.shared.clearMemory()
        }
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        let tabBarController = UITabBarController()
        let persistenceManager = UserDefaultsPersistenceManager()
        
        let searchNavigationController = UINavigationController()
        let searchTabRouter = TabRouter(navigationController: searchNavigationController, persistenceManager: persistenceManager)
        
        // launch screen
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "LaunchScreenViewController")
        
        let welcomeScreenNavigationController = UINavigationController()
        let welcomeScreenTabRouter = TabRouter(navigationController: welcomeScreenNavigationController, persistenceManager: persistenceManager)
        let viewModel = WelcomeScreenViewModel()
        let welcomeScreen = WelcomeScreenViewController(tabRouter: welcomeScreenTabRouter, viewModel: viewModel)
        welcomeScreenNavigationController.viewControllers = [welcomeScreen]
        welcomeScreen.tabBarItem = UITabBarItem(title: "Home", image: Constants.homekitImage, selectedImage: Constants.homekitImage)
        
        let favouritesNavigationController = UINavigationController()
        let favouritesTabRouter = TabRouter(navigationController: favouritesNavigationController, persistenceManager: persistenceManager)
        let favouritesViewController = FavouritesViewController(tabRouter: favouritesTabRouter, persistenceManager: persistenceManager)
        favouritesNavigationController.viewControllers = [favouritesViewController]
        favouritesViewController.tabBarItem = UITabBarItem(title: "Fav", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemPink], for: .normal)
        
        let searchViewController = SearchViewController(tabRouter: searchTabRouter)
        searchNavigationController.viewControllers = [searchViewController]
        
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: Constants.magnifyingGlassImage, selectedImage: Constants.magnifyingGlassImage)

        tabBarController.viewControllers = [searchNavigationController, favouritesNavigationController]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
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


