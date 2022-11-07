//
//  PokemonsViewModel.swift
//  Pokedex
//
//  Created by Majka on 26/10/2022.
//

import Foundation

protocol PokemonListViewModelProtocol: AnyObject {
    var delegate: PokemonListViewModelDelegate? { get set }
    var dataSource: [Results] { get }
    func getNextPage()
    func getPokemonImageUrl(forRow row: Int) -> String 
}

protocol PokemonListViewModelDelegate: AnyObject {
    func onGetPageSuccess()
    func onGetPageFailure(error: String)
}

class PokemonListViewModel: PokemonListViewModelProtocol {
    
    weak var delegate: PokemonListViewModelDelegate?
    var urlString: String = "https://pokeapi.co/api/v2/pokemon/"
    private let service = PokemonAPIService()
    var dataSource: [Results] = []
    private let baseImageUrlString: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    
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
    
    func getPokemonImageUrl(forRow row: Int) -> String {
        "\(baseImageUrlString)\(row + 1).png"
    }
    
}
