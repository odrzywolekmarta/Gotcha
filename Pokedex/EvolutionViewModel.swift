//
//  EvolutionViewModel.swift
//  Gotcha
//
//  Created by Majka on 13/11/2022.
//

import Foundation

protocol EvolutionViewModelProtocol: AnyObject {
    var delegate: EvolutionViewModelDelegate? { get set }
    var evolutionModel: EvolutionModel? { get }
    func getEvolution(id: Int)
}

protocol EvolutionViewModelDelegate: AnyObject {
    func onEvolutionModelFetchSuccess()
    func onEvolutionModelFetchFailure(error: String)
}

class EvolutionViewModel: EvolutionViewModelProtocol {
    var evolutionModel: EvolutionModel?
    weak var delegate: EvolutionViewModelDelegate?
    private let service = PokemonAPIService()
    
    func getEvolution(id: Int) {
        service.getEvolution(withId: id) { [weak self] result in
            switch result {
            case .success(let model):
                self?.evolutionModel = model
                self?.delegate?.onEvolutionModelFetchSuccess()
            case .failure(let error):
                self?.delegate?.onEvolutionModelFetchFailure(error: error.localizedDescription)
            }
        }
    }
    
}
