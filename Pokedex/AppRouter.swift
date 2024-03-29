//
//  AppRouter.swift
//  Pokedex
//
//  Created by Majka on 08/11/2022.
//

import Foundation
import UIKit
import SafariServices

protocol AppRouterProtocol {
    func navigateToDetails(urlString: String, imageUrl: String)
    func navigateToDetails(withModel model: PokemonModel)
    func navigateToDetails(urlString: String)
    func navigateToType(withModel model: TypeModel)
    func navigateToPokeball(withModel model: PokeballModel)
    func navigateToList(withData: [Pokemon])
    func navigateToAbility(withModel model: AbilityModel)
    func showWebView(urlString: String)
}

class AppRouter: AppRouterProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToList(withData data: [Pokemon]) {
        let controller = PokemonViewController(viewModel: PokemonListViewModel(typePokemon: data, service: PokemonAPIService()), router: self, openedFrom: .type)
        navigationController.pushViewController(controller, animated: true)
    }

    func navigateToDetails(urlString: String) {
        let controller = PokemonDetailsViewController(viewModel: PokemonDetailsViewModel(urlString: urlString,
                                                                                         service: PokemonAPIService()),
                                                      router: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func navigateToDetails(urlString: String, imageUrl: String) {
        let controller = PokemonDetailsViewController(viewModel: PokemonDetailsViewModel(urlString: urlString, imageUrl: imageUrl,
                                                                                         service: PokemonAPIService()),
                                                      router: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func navigateToDetails(withModel model: PokemonModel) {
        let controller = PokemonDetailsViewController(viewModel: PokemonDetailsViewModel(detailsModel: model,
                                                                                         service: PokemonAPIService()),
                                                      router: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func navigateToType(withModel model: TypeModel) {
        let controller = TypeDetailsViewController(viewModel: TypeDetailsViewModel(service: PokemonAPIService(), detailsModel: model), router: self)
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.view.applyShadow()
        navigationController.present(controller, animated: true)
    }
    
    func navigateToPokeball(withModel model: PokeballModel) {
        let controller = PokeballDetailsViewController(router: self, viewModel: PokeballDetailsViewModel(detailsModel: model))
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.view.applyShadow()
        
        navigationController.present(controller, animated: true)
    }
    
    func navigateToAbility(withModel model: AbilityModel) {
        let controller = AbilityDetailsViewController(router: self, viewModel: AbilityDetailsViewModel(detailsModel: model))
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.view.applyShadow()
        
        navigationController.present(controller, animated: true)
    }
    
    func showWebView(urlString: String) {
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            navigationController.present(vc, animated: true)
        }
    }
    
}
