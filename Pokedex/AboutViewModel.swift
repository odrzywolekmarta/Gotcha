//
//  AboutViewModel.swift
//  Gotcha
//
//  Created by Majka on 13/11/2022.
//

import Foundation

protocol AboutViewModelProtocol: AnyObject {
    var delegate: AboutViewModelDelegate? { get set }
    var detailsModel: PokemonModel? { get }
    var abilityModel: AbilityModel? { get }
    var speciesModel: SpeciesModel? { get }
    var typeModel: TypeModel? { get }
    func set(pokemonModel: PokemonModel, speciesModel: SpeciesModel?)
    func getAbilityDetails(for ability: String)
    func getTypeDetails(forType type: String)
}

protocol AboutViewModelDelegate: AnyObject {
    func onDetailsModelSet()
    func onAbilityDetailsSuccess()
    func onAbilityDetailsFailure(error: Error)
    func onTypeDetailsModelFetchSuccess()
    func onTypeDetailsModelFetchFailure(error: Error)
}

class AboutViewModel: AboutViewModelProtocol {
    weak var delegate: AboutViewModelDelegate?
    var detailsModel: PokemonModel?
    var abilityModel: AbilityModel?
    var speciesModel: SpeciesModel?
    var typeModel: TypeModel?
    private let service: PokemonAPIServiceProtocol
    
    init(service: PokemonAPIServiceProtocol) {
        self.service = service
    }
  
    func set(pokemonModel: PokemonModel, speciesModel: SpeciesModel? = nil) {
        detailsModel = pokemonModel
        self.speciesModel = speciesModel
        delegate?.onDetailsModelSet()
    }

    func getAbilityDetails(for ability: String) {
        service.getAbilityDetails(for: ability) { [weak self] abilityResult in
            switch abilityResult {
            case .success(let abilityModel):
                self?.abilityModel = abilityModel
                self?.delegate?.onAbilityDetailsSuccess()
            case .failure(let error):
                self?.delegate?.onAbilityDetailsFailure(error: error)
            }
        }
    }
    
    func getTypeDetails(forType type: String) {
        if let url = URL(string: "https://pokeapi.co/api/v2/type/\(type)") {
            service.getTypeDetails(withUrl: url) { [weak self] result in
                switch result {
                case .success(let model):
                    self?.typeModel = model
                    self?.delegate?.onTypeDetailsModelFetchSuccess()
                case .failure(let error):
                    self?.delegate?.onTypeDetailsModelFetchFailure(error: error)
                }
            }
        }
    }
}
