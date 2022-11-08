//
//  AppRouter.swift
//  Pokedex
//
//  Created by Majka on 08/11/2022.
//

import Foundation
import UIKit

protocol AppRouterProtocol {
    func navigateToDetails(withUrlString urlString: String)
}

class AppRouter: AppRouterProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToDetails(withUrlString urlString: String) {
        let controller = PokemonDetailsViewController(viewModel: PokemonDetailsViewModel(urlString: urlString))
        navigationController.pushViewController(controller, animated: true)
    }
    
}
