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
    var typePokemon: [Pokemon] { get }
    func getNextPage()
    func getPokemonImageUrl(forRow row: Int, openedFrom: OpenedFrom) -> String
}

protocol PokemonListViewModelDelegate: AnyObject {
    func onGetPageSuccess()
    func onGetPageFailure(error: String)
}

class PokemonListViewModel: PokemonListViewModelProtocol {
    
    weak var delegate: PokemonListViewModelDelegate?
    var urlString = Constants.basePokemonUrl
    private let service: PokemonAPIServiceProtocol
    var dataSource: [Results] = []
    var typePokemon: [Pokemon] = []
    private let baseImageUrlString = Constants.baseImageUrl
    
    init(service: PokemonAPIServiceProtocol) {
        self.service = service
    }
    
    init(typePokemon: [Pokemon], service: PokemonAPIServiceProtocol) {
        self.typePokemon = typePokemon
        self.service = service
    }
    
    func getNextPage() {
        service.getPokemonList(withUrlString: urlString) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.onGetPageFailure(error: error.localizedDescription)
            case .success(let data):
                self?.urlString = data.next ?? ""
                self?.dataSource.append(contentsOf: data.results)
                self?.delegate?.onGetPageSuccess()
            }
        }
    }
    
    func getPokemonImageUrl(forRow row: Int, openedFrom: OpenedFrom) -> String {
        let imageUrl: String
        switch openedFrom {
        case .listTab:
            let pokeUrl = dataSource[row].url
            var startImageUrl = pokeUrl.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/")
            startImageUrl = String(startImageUrl.dropLast(1))
            imageUrl = startImageUrl + ".png"
            return imageUrl
        case .type:
            let pokeUrl = typePokemon[row].pokemon.url
            var startImageUrl = pokeUrl.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/")
            startImageUrl = String(startImageUrl.dropLast(1))
            imageUrl = startImageUrl + ".png"
            return imageUrl
        }
    }
    
}
