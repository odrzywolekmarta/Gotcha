//
//  PokemonAPIServive.swift
//  Pokedex
//
//  Created by Majka on 26/10/2022.
//

import Foundation

class PokemonAPIService {

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
    
    func getPokemonList(withUrlString urlString: String, completion: @escaping ((Result<SinglePageModel, Error>) -> Void)) {
        guard let url = URL(string: urlString) else {
            print("error: could not create url from: \(urlString)")
            completion(.failure(PokemonAPIServiceError.noUrl))
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let singlePage = try decoder.decode(SinglePageModel.self, from: data)
                    completion(.success(singlePage))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(PokemonAPIServiceError.unknown))
            }
        }
        dataTask.resume()
    }

    
        
        
    
}
