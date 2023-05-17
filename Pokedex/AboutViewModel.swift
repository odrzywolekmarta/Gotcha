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
    func set(pokemonModel: PokemonModel, speciesModel: SpeciesModel?)
    func getAbilityDetails(for ability: String)
}

protocol AboutViewModelDelegate: AnyObject {
    func onDetailsModelSet()
    func onAbilityDetailsSuccess()
    func onAbilityDetailsFailure(error: Error)
}

class AboutViewModel: AboutViewModelProtocol {
    weak var delegate: AboutViewModelDelegate?
    var detailsModel: PokemonModel?
    var abilityModel: AbilityModel?
    var speciesModel: SpeciesModel?
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
}
