//
//  AppRouter.swift
//  Pokedex
//
//  Created by Majka on 08/11/2022.
//

import Foundation
import UIKit

protocol AppRouterProtocol {
    func navigateToDetails(urlString: String, imageUrl: String)
    func navigateToDetails(withModel model: PokemonModel)
    func navigateToDetails(urlString: String)
}

class AppRouter: AppRouterProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToDetails(urlString: String) {
        let controller = PokemonDetailsViewController(viewModel: PokemonDetailsViewModel(urlString: urlString), router: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func navigateToDetails(urlString: String, imageUrl: String) {
        let controller = PokemonDetailsViewController(viewModel: PokemonDetailsViewModel(urlString: urlString, imageUrl: imageUrl), router: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func navigateToDetails(withModel model: PokemonModel) {
        let controller = PokemonDetailsViewController(viewModel: PokemonDetailsViewModel(detailsModel: model), router: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
}
