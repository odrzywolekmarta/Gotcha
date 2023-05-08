//
//  TypeDetailsViewModel.swift
//  Gotcha
//
//  Created by Majka on 07/04/2023.
//

import Foundation

protocol TypeDetailsViewModelProtocol: AnyObject {
    var delegate: TypeDetailsViewModelDelegate? { get set }
    var detailsModel: TypeModel { get }
}

protocol TypeDetailsViewModelDelegate: AnyObject {
}

class TypeDetailsViewModel: TypeDetailsViewModelProtocol {    
    var delegate: TypeDetailsViewModelDelegate?
    var detailsModel: TypeModel
    private let service: PokemonAPIServiceProtocol
    
    init(service: PokemonAPIServiceProtocol, detailsModel: TypeModel) {
        self.service = service
        self.detailsModel = detailsModel
    }
}
