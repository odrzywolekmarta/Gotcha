//
//  PokemonAPIServive.swift
//  Pokedex
//
//  Created by Majka on 26/10/2022.
//

import Foundation

class PokemonAPIService {

    var url = "https://pokeapi.co/api/v2/pokemon/"
    var count = 0
    var pokemonArray: [Results] = []
    
    struct Returned: Decodable {
        let count: Int
        let next: String
        let results: [Results]
    }
    
    struct Results: Decodable {
        let name: String
        let url: String
    }
    
    func getPokemonList(completion: @escaping () ->()) {
        let urlString = url
        guard let url = URL(string: urlString) else {
            print("error: could not create url from: \(urlString)")
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let returned = try decoder.decode(Returned.self, from: data)
                    print(returned)
                    self.count = returned.count
                    self.url = returned.next
                    self.pokemonArray = returned.results
                    print(self.pokemonArray)
                } catch {
                    print("error: \(error.localizedDescription)")
                }
            }
        }
        dataTask.resume()
    }

    
        
        
    
}
