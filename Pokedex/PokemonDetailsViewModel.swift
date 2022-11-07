//
//  PokemonDetailsViewModel.swift
//  Pokedex
//
//  Created by Majka on 07/11/2022.
//

import Foundation

protocol PokemonDetailsViewModelProtocol: AnyObject {
    var delegate: PokemonListViewModelDelegate? { get set }
    var detailsModel: PokemonModel? { get }
    func getPokemonDetails(withUrlString urlString: String)
}

protocol PokemonDetailsViewModelDelegate: AnyObject {
    func onDetailsModelFetchSuccess()
    func onDetailsModelFetchFailure()
}

class PokemonDetailsViewModel: PokemonDetailsViewModelProtocol {
    
    var delegate: PokemonListViewModelDelegate?
    var detailsModel: PokemonModel?
    private let service = PokemonAPIService()
    
    func getPokemonDetails(withUrlString urlString: String) {
        service.getPokemonDetails(withUrlString: urlString) { [weak self] result in
            switch result {
            case .success(let model):
                self?.detailsModel = model
                self?.delegate?.onGetPageSuccess()
            case .failure(let error):
                self?.delegate?.onGetPageFailure(error: error.localizedDescription)
            }
        }
    }
    
    
    
}
