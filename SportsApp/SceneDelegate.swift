//
//  SceneDelegate.swift
//  SportsApp
//
//  Created by eslam mohamed on 21/02/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let userDefaults = UserDefaults.standard



    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        var rootVC = window?.rootViewController

        if !userDefaults.bool(forKey: "firstTimeToUseApplication"){
            rootVC = createStartNC()
        }else{
            rootVC = createTabBarController()

        }
        
        
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        
    }

    
    private func createStartNC()->UINavigationController{
//        let startNC = SecondStartVC()
        let startNC = StartScreenVC()
        userDefaults.set(true, forKey: "firstTimeToUseApplication")
        return UINavigationController(rootViewController: startNC)
    }
    
    
    private func createHomeNC()->UINavigationController{
        let homeNC = HomeVC()
        homeNC.tabBarItem = UITabBarItem(title: "Sports", image: UIImage(named: "homeIcon"), tag: 1)
        
        return UINavigationController(rootViewController: homeNC)
    }
    
    private func createFavoritesNC()-> UINavigationController{
        let favoriteNC = FavoritesVC()
        favoriteNC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "favoriteIcon"), tag: 2)
        return UINavigationController(rootViewController: favoriteNC)
    }
    
    private func createNotificationsNC()-> UINavigationController{
        let notificationsNC = NotificationsVC()
        notificationsNC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "notificationIcon"), tag: 3)
        return UINavigationController(rootViewController: notificationsNC)
    }
    
    private func createSettingNC()-> UINavigationController{
        let settingNC = SettingVC()
        settingNC.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(named: "settingsIcon"), tag: 4)

        return UINavigationController(rootViewController: settingNC)
    }

    
    func createTabBarController() -> UITabBarController{
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = UIColor.init(red: 214/255, green: 24/255, blue: 42/255, alpha: 1)
        tabBar.viewControllers = [createHomeNC(),createFavoritesNC()]
//        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .white
        
        return tabBar
    }

    
    
    
    
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

