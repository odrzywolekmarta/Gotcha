//
//  PokemonsViewModel.swift
//  Pokedex
//
//  Created by Majka on 26/10/2022.
//

import Foundation

protocol PokemonViewModelProtocol: AnyObject {
    var delegate: PokemonViewModelDelegate? { get set }
    var dataSource: [Results] { get }
    func getNextPage()
}

protocol PokemonViewModelDelegate: AnyObject {
    func onGetPageSuccess()
    func onGetPageFailure(error: String)
}

class PokemonViewModel: PokemonViewModelProtocol {
    weak var delegate: PokemonViewModelDelegate?
    var urlString: String = "https://pokeapi.co/api/v2/pokemon/"
    private let service = PokemonAPIService()
    var dataSource: [Results] = []
    
    func getNextPage() {
        service.getPokemonList(withUrlString: urlString) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.onGetPageFailure(error: error.localizedDescription)
            case .success(let data):
                self?.urlString = data.next
                self?.dataSource.append(contentsOf: data.results)
                self?.delegate?.onGetPageSuccess()
            }
        }
    }
    
}
