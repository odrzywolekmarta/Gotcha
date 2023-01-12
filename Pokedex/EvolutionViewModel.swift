//
//  EvolutionViewModel.swift
//  Gotcha
//
//  Created by Majka on 13/11/2022.
//

import Foundation

protocol EvolutionViewModelProtocol: AnyObject {
    var delegate: EvolutionViewModelDelegate? { get set }
    var simplifiedEvolutionSetModel: SimplifiedEvolutionSetModel? { get }
    func getEvolution(withSpeciesUrl url: URL)
    func getPokemonImageUrl(forSpeciesId id: String?) -> URL?
}

protocol EvolutionViewModelDelegate: AnyObject {
    func onEvolutionModelFetchSuccess()
    func onEvolutionModelFetchFailure(error: String)
}

struct SimplifiedEvolutionSetModel {
    
    let evolutionsIdsArray: [String]
    
    init(with model: EvolutionModel) {
        let firstEvolution = model.chain
        let secondEvolution = firstEvolution.evolvesTo.first
        let thirdEvolution = secondEvolution?.evolvesTo.first
        
        let firstId = firstEvolution.species.url.pathComponents.last
        let secondId = secondEvolution?.species.url.pathComponents.last
        let thirdId = thirdEvolution?.species.url.pathComponents.last
                
        self.evolutionsIdsArray = [firstId, secondId, thirdId].compactMap { $0 }
    }
}

class EvolutionViewModel: EvolutionViewModelProtocol {
    
    var evolutionModel: EvolutionModel?
    var simplifiedEvolutionSetModel: SimplifiedEvolutionSetModel?
    
    weak var delegate: EvolutionViewModelDelegate?
    private let service = PokemonAPIService()
    
    func getEvolution(withSpeciesUrl url: URL) {
        service.getSpecies(withUrl: url) { [weak self] speciesResult in
            switch speciesResult {
            case .success(let speciesModel):
                self?.service.getEvolution(withUrl: speciesModel.evolutionChain.url) { evolutionResult in
                    switch evolutionResult {
                    case .success(let evolutionModel):
                        self?.simplifiedEvolutionSetModel = SimplifiedEvolutionSetModel(with: evolutionModel)
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
    
    func getPokemonImageUrl(forSpeciesId id: String?) -> URL? {
        guard let id = id else {
            return nil
        }
        return URL(string: "\(Constants.pokemonDetailsImage)\(id).png")
    }
    
}
