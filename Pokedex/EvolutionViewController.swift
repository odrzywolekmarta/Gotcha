//
//  EvolutionViewController.swift
//  Gotcha
//
//  Created by Majka on 13/11/2022.
//

import UIKit

class EvolutionViewController: UIViewController {

    let viewModel: EvolutionViewModelProtocol = EvolutionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Evolution View Model Delegate

extension EvolutionViewController: EvolutionViewModelDelegate {
    func onEvolutionModelFetchSuccess() {
        DispatchQueue.main.async {
            if let model = self.viewModel.evolutionModel {
                print(model)
            }
        }
    }

    func onEvolutionModelFetchFailure(error: String) {
        DispatchQueue.main.async {
        }
        print(error)
    }

}
