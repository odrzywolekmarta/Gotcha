//
//  PokemonDetailsViewModel.swift
//  Pokedex
//
//  Created by Majka on 07/11/2022.
//

import Foundation

protocol PokemonDetailsViewModelProtocol: AnyObject {
    var delegate: PokemonDetailsViewModelDelegate? { get set }
    var detailsModel: PokemonModel? { get }
    var persistedModel: PersistedModel? { get set }
    var imageUrl: String? { get }
    func getPokemonDetails()
}

protocol PokemonDetailsViewModelDelegate: AnyObject {
    func onDetailsModelFetchSuccess()
    func onDetailsModelFetchFailure(error: Error)
    func onEvolutionModelFetchSuccess()
    func onEvolutionModelFetchFailure(error: Error)
}

class PokemonDetailsViewModel: PokemonDetailsViewModelProtocol {
    
    weak var delegate: PokemonDetailsViewModelDelegate?
    var detailsModel: PokemonModel?
    var speciesModel: EvolutionModel?
    var persistedModel: PersistedModel?
    private let service: PokemonAPIServiceProtocol
    private var urlString: String?
    var imageUrl: String?
    
    init(urlString: String, imageUrl: String, service: PokemonAPIServiceProtocol) {
        self.urlString = urlString
        self.imageUrl = imageUrl
        self.service = service
    }
        
    init(detailsModel: PokemonModel, service: PokemonAPIServiceProtocol) {
        self.detailsModel = detailsModel
        self.service = service
    }
    
    init(urlString: String, service: PokemonAPIServiceProtocol) {
        self.urlString = urlString
        self.service = service
    }
    
    func getPokemonDetails() {
        if let url = urlString {
            service.getPokemonDetails(withUrlString: url) { [weak self] result in
                switch result {
                case .success(let model):
                    self?.detailsModel = model
                    self?.service.getEvolution(withUrl: model.species.url, completion: { result in
                        switch result {
                        case .success(let speciesModel):
                            self?.speciesModel = speciesModel
                            self?.delegate?.onEvolutionModelFetchSuccess()
                        case .failure(let error):
                            self?.delegate?.onEvolutionModelFetchFailure(error: error)
                        }
                    })
                    self?.delegate?.onDetailsModelFetchSuccess()
                case .failure(let error):
                    self?.delegate?.onDetailsModelFetchFailure(error: error)
                } 
            }
        }
    }
}
