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
        
        let launchScreen = LaunchScreenViewController()
        launchScreen.delegate = self
        window?.rootViewController = launchScreen
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate: LaunchScreenViewControllerDelegate {
    func onAnimationFinished() {
        let tabBarController = UITabBarController()
        let allNavigationController = UINavigationController()
        let searchNavigationController = UINavigationController()
        let favouritesNavigationController = UINavigationController()
        
        allNavigationController.tabBarItem = UITabBarItem(title: Constants.tabNameAll.uppercased(), image: Constants.listBulletImage, selectedImage: Constants.listBulletImage)
        
        let favouritesViewController = FavouritesViewController(router: AppRouter(navigationController: favouritesNavigationController))
        favouritesNavigationController.viewControllers = [favouritesViewController]
        favouritesViewController.tabBarItem = UITabBarItem(title: Constants.tabNameFavourites.uppercased(), image: Constants.heartImage, selectedImage: Constants.heartFillImage)
        
        let searchViewController = SearchViewController(router: AppRouter(navigationController: searchNavigationController))
        searchNavigationController.viewControllers = [searchViewController]
        searchViewController.tabBarItem = UITabBarItem(title: Constants.tabNameSearch.uppercased(), image: Constants.magnifyingGlassImage, selectedImage: Constants.magnifyingGlassImage)
        
        tabBarController.viewControllers = [allNavigationController, searchNavigationController, favouritesNavigationController]
        tabBarController.tabBar.tintColor = UIColor(named: Constants.Colors.customRed)
        
        let controller = PokemonViewController(viewModel: PokemonListViewModel(service: PokemonAPIService()), router: AppRouter(navigationController: allNavigationController))
        allNavigationController.setViewControllers([controller], animated: false)
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
                
        allNavigationController.navigationBar.update(backroundColor: UIColor(named: Constants.Colors.customRed), titleColor: .black)
        searchNavigationController.navigationBar.update(backroundColor: UIColor(named: Constants.Colors.customBeige), titleColor: .black)
        favouritesNavigationController.navigationBar.update(backroundColor: UIColor(named: Constants.Colors.customRed), titleColor: .black)
        
        // TODO: make bar title configuration reusable
        let allNavigationBar
        = allNavigationController.navigationBar
        let titleFrame = CGRect(x: 0, y: 0, width: allNavigationBar.frame.width, height: allNavigationBar.frame.height)
        let titleLabel = UILabel(frame: titleFrame)
        titleLabel.text = Constants.gotcha.uppercased()
        titleLabel.applyShadow()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: Constants.customFontBold, size: 23)
        allNavigationBar.addSubview(titleLabel)

        
        let favNavigationBar = favouritesNavigationController.navigationBar
        let titleFramee = CGRect(x: 0, y: 0, width: allNavigationBar.frame.width, height: allNavigationBar.frame.height)
        let titleLabell = UILabel(frame: titleFramee)
        titleLabell.text = Constants.gotcha.uppercased()
        titleLabell.applyShadow()
        titleLabell.textAlignment = .center
        titleLabell.textColor = .white
        titleLabell.font = UIFont(name: Constants.customFontBold, size: 23)
        favNavigationBar.addSubview(titleLabell)
    }
}
