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
    func getPokemonDetails()
}

protocol PokemonDetailsViewModelDelegate: AnyObject {
    func onDetailsModelFetchSuccess()
    func onDetailsModelFetchFailure(error: String)
}

class PokemonDetailsViewModel: PokemonDetailsViewModelProtocol {
    
    var delegate: PokemonDetailsViewModelDelegate?
    var detailsModel: PokemonModel?
    private let service = PokemonAPIService()
    private let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func getPokemonDetails() {
        service.getPokemonDetails(withUrlString: urlString) { [weak self] result in
            switch result {
            case .success(let model):
                self?.detailsModel = model
                self?.delegate?.onDetailsModelFetchSuccess()
            case .failure(let error):
                self?.delegate?.onDetailsModelFetchFailure(error: error.localizedDescription)
            }
        }
    }
}
