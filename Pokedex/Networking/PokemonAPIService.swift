//
//  PokemonAPIServive.swift
//  Pokedex
//
//  Created by Majka on 26/10/2022.
//

import Foundation

struct Results: Decodable {
    let name: String
    let url: String
}

protocol PokemonAPIServiceProtocol {
    func getPokemonList(withUrlString urlString: String, completion: @escaping ((Result<SinglePageModel, Error>) -> Void))
    func getPokemonDetails(withUrlString urlString: String, completion: @escaping((Result<PokemonModel,Error>) -> Void))
    func getSpecies(withUrl url: URL, completion: @escaping((Result<SpeciesModel, Error>)) -> Void)
    func getEvolution(withUrl url: URL, completion: @escaping((Result<EvolutionModel, Error>) -> Void))
    func getAbilityDetails(for ability: String, completion: @escaping((Result<AbilityModel, Error>) -> Void))
}

struct SinglePageModel: Decodable {
    let next: String?
    let results: [Results]
}

class PokemonAPIService: PokemonAPIServiceProtocol {
    var count = 0
    var pokemonArray: [Results] = []
    
    enum PokemonAPIServiceError: LocalizedError {
        case noUrl
        case unknown
    }
    
    func getPokemonList(withUrlString urlString: String, completion: @escaping ((Result<SinglePageModel, Error>) -> Void)) {
        guard let url = URL(string: urlString) else {
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
                    debugPrint(error)
                }
            } else {
                completion(.failure(PokemonAPIServiceError.unknown))
            }
        }
        dataTask.resume()
    }
    
    func getPokemonDetails(withUrlString urlString: String, completion: @escaping((Result<PokemonModel,Error>) -> Void)) {
        guard let url = URL(string: urlString) else {
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
                    let pokemonDetails = try decoder.decode(PokemonModel.self, from: data)
                    completion(.success(pokemonDetails))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(PokemonAPIServiceError.unknown))
            }
        }
        dataTask.resume()
    }
    
    func getSpecies(withUrl url: URL, completion: @escaping((Result<SpeciesModel, Error>)) -> Void) {
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let species = try decoder.decode(SpeciesModel.self, from: data)
                    completion(.success(species))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(PokemonAPIServiceError.unknown))
            }
        }
        dataTask.resume()
    }
    
    func getEvolution(withUrl url: URL, completion: @escaping((Result<EvolutionModel, Error>) -> Void)) {
        
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let evolution = try decoder.decode(EvolutionModel.self, from: data)
                    completion(.success(evolution))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(PokemonAPIServiceError.unknown))
            }
        }
        dataTask.resume()
    }
    
    func getAbilityDetails(for ability: String, completion: @escaping((Result<AbilityModel, Error>) -> Void)) {
        let urlString = "\(Constants.baseAbilityUrl)\(ability)"
        
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let dataTask = urlSession.dataTask(with: url) { (data, response, error ) in
                if let error = error {
                    completion(.failure(error))
                    return
                } else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let ability = try decoder.decode(AbilityModel.self, from: data)
                        completion(.success(ability))
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
}
