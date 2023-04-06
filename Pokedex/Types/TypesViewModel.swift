//
//  TypesViewModel.swift
//  Gotcha
//
//  Created by Majka on 30/03/2023.
//

import Foundation

protocol TypesViewModelProtocol: AnyObject {
    var delegate: TypesViewModelDelegate? { get set }
    var dataSource: [Results] { get }
    func getPokemonTypes()
}

protocol TypesViewModelDelegate: AnyObject {
    func onTypesFetchSuccess()
    func onTypesFetchFailure(error: String)
}

class TypesViewModel: TypesViewModelProtocol {
    var delegate: TypesViewModelDelegate?
    let urlString = Constants.typesUrl
    private let service: PokemonAPIServiceProtocol
    var dataSource: [Results] = []
    
    
    init(service: PokemonAPIServiceProtocol) {
        self.service = service
    }
    
    func getPokemonTypes() {
        service.getPokemonList(withUrlString: urlString) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.onTypesFetchFailure(error: error.localizedDescription)
            case .success(let data):
                self?.dataSource.append(contentsOf: data.results)
                self?.delegate?.onTypesFetchSuccess()
            }
        }
    }
}
