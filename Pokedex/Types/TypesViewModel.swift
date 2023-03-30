//
//  TypesViewModel.swift
//  Gotcha
//
//  Created by Majka on 30/03/2023.
//

import Foundation

protocol TypesViewModelProtocol: AnyObject {
    var delegate: TypesViewModelDelegate? { get set }
}

protocol TypesViewModelDelegate: AnyObject {
    func onTypesFetchSuccess()
    func onTypesFetchFailure()
}

class TypesViewModel: TypesViewModelProtocol {
    var delegate: TypesViewModelDelegate?
    private let service: PokemonAPIServiceProtocol
    
    init(service: PokemonAPIServiceProtocol) {
        self.service = service
    }
}
