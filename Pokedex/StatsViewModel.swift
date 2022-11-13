//
//  StatsViewModel.swift
//  Gotcha
//
//  Created by Majka on 13/11/2022.
//

import Foundation

protocol StatsViewModelProtocol: AnyObject {
    var delegate: StatsViewModelDelegate? { get set }
    var detailsModel: PokemonModel? { get }
    // TODO: create PokemonModelSettable protocol and implement on view models
    func set(model: PokemonModel)
}

protocol StatsViewModelDelegate: AnyObject {
    func onDetailsModelSet()
}

class StatsViewModel: StatsViewModelProtocol {
    
    weak var delegate: StatsViewModelDelegate?
    var detailsModel: PokemonModel?
  
    func set(model: PokemonModel) {
        detailsModel = model
        delegate?.onDetailsModelSet()
    }
}
