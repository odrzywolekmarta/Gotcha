//
//  PokemonsViewModel.swift
//  Pokedex
//
//  Created by Majka on 26/10/2022.
//

import Foundation

protocol PokemonViewModelProtocol {
    func getNextPage()
}

class PokemonViewModel: PokemonViewModelProtocol {
    
    var urlString: String = "https://pokeapi.co/api/v2/pokemon/"
    private let service = PokemonAPIService()
    
    func getNextPage() {
        service.getPokemonList(withUrlString: urlString) { result in
            switch result {
            case .failure(let error):
                ()
            case .success(let data):
                ()
            }
        }
    }
    
}
