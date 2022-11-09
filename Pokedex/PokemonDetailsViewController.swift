//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Majka on 06/11/2022.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    let viewModel: PokemonDetailsViewModelProtocol
    let router: AppRouterProtocol

    init(viewModel: PokemonDetailsViewModelProtocol, router: AppRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getPokemonDetails()
    }
}


//MARK: - View Model Delegate

extension PokemonDetailsViewController: PokemonDetailsViewModelDelegate {
    func onDetailsModelFetchSuccess() {
        DispatchQueue.main.async {
        }
    }

    func onDetailsModelFetchFailure(error: String) {
        DispatchQueue.main.async {
        }
        print(error)
    }
}

