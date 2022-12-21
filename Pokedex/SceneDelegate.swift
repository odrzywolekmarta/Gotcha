//
//  SceneDelegate.swift
//  Pokedex
//
//  Created by Majka on 26/10/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let tabBarController = UITabBarController()
        let allNavigationController = UINavigationController()
        let searchNavigationController = UINavigationController()
        let favouritesNavigationController = UINavigationController()
        
        allNavigationController.tabBarItem = UITabBarItem(title: "ALL", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        
        let favouritesViewController = FavouritesViewController()
        favouritesNavigationController.viewControllers = [favouritesViewController]
        favouritesViewController.tabBarItem = UITabBarItem(title: "FAVOURITES", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))       
        
        let searchViewController = SearchViewController(router: AppRouter(navigationController: searchNavigationController))
        searchNavigationController.viewControllers = [searchViewController]
        searchViewController.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        tabBarController.viewControllers = [allNavigationController, searchNavigationController, favouritesNavigationController]
        
        let controller = PokemonViewController(viewModel: PokemonListViewModel(), router: AppRouter(navigationController: allNavigationController))
        
        allNavigationController.setViewControllers([controller], animated: false)
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
        
        allNavigationController.navigationBar.update(backroundColor: UIColor(named: Constants.Colors.customRed), titleColor: .black)
        searchNavigationController.navigationBar.update(backroundColor: UIColor(named: Constants.Colors.customBeige), titleColor: .black)
        favouritesNavigationController.navigationBar.update(backroundColor: UIColor(named: Constants.Colors.customRed), titleColor: .black)
        
        let allNavigationBar = allNavigationController.navigationBar
        let titleFrame = CGRect(x: 0, y: 0, width: allNavigationBar.frame.width, height: allNavigationBar.frame.height)
        let titleLabel = UILabel(frame: titleFrame)
        titleLabel.text = "GOTCHA"
        titleLabel.applyShadow()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: Constants.customFontBold, size: 23)
        allNavigationBar.addSubview(titleLabel)
        
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
    }
}

