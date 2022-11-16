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
    // TODO: create PokemonModelSettable protowcol and implement on view models
    func set(model: PokemonModel)
}

protocol AboutViewModelDelegate: AnyObject {
    func onDetailsModelSet()
}

class AboutViewModel: AboutViewModelProtocol {
    
    weak var delegate: AboutViewModelDelegate?
    var detailsModel: PokemonModel?
  
    func set(model: PokemonModel) {
        detailsModel = model
        delegate?.onDetailsModelSet()
    }
}
