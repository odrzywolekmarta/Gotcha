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
    
    enum PokemonAPIServiceError: LocalizedError {
        case noUrl
        case unknown
    }
    
    struct SinglePageModel: Decodable {
        let next: String
        let results: [Results]
    }
    
    struct Results: Decodable {
        let name: String
        let url: String
    }
    
    func getPokemonList(completion: @escaping ((Result<SinglePageModel, Error>) -> Void)) {
        let urlString = url
        guard let url = URL(string: urlString) else {
            print("error: could not create url from: \(urlString)")
            completion(.failure(PokemonAPIServiceError.noUrl))
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let singlePage = try decoder.decode(SinglePageModel.self, from: data)
                    print(singlePage)
                    self.url = singlePage.next
                    self.pokemonArray = singlePage.results
                    print(self.pokemonArray)
                    completion(.success(singlePage))
                } catch {
                    print("error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            } else {
                completion(.failure(PokemonAPIServiceError.unknown))
            }
        }
        dataTask.resume()
    }

    
        
        
    
}
