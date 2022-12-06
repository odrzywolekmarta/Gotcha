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
    var speciesModel: SpeciesModel? { get }
    func getEvolution(withSpeciesUrl url: URL)
    func getPokemonImageUrl(forSpeciesId id: Int) -> String
}

protocol EvolutionViewModelDelegate: AnyObject {
    func onEvolutionModelFetchSuccess()
    func onEvolutionModelFetchFailure(error: String)
}

class EvolutionViewModel: EvolutionViewModelProtocol {
    
    var speciesModel: SpeciesModel?
    var evolutionModel: EvolutionModel?
    weak var delegate: EvolutionViewModelDelegate?
    private let service = PokemonAPIService()
    
    func getEvolution(withSpeciesUrl url: URL) {
        service.getSpecies(withUrl: url) { [weak self] speciesResult in
            switch speciesResult {
            case .success(let speciesModel):
                self?.service.getEvolution(withUrl: speciesModel.evolutionChain.url) { evolutionResult in
                    switch evolutionResult {
                    case .success(let evolutionModel):
                        self?.evolutionModel = evolutionModel
                        print(evolutionModel)
                        self?.delegate?.onEvolutionModelFetchSuccess()
                    case .failure(let error):
                        self?.delegate?.onEvolutionModelFetchFailure(error: error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                self?.delegate?.onEvolutionModelFetchFailure(error: error.localizedDescription)
            }
        }
    }
    
    func getPokemonImageUrl(forSpeciesId id: Int) -> String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
    
}
