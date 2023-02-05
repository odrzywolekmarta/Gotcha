//
//  MockPokemonApiService.swift
//  GotchaTests
//
//  Created by Majka on 12/01/2023.
//

import Foundation
@testable import Gotcha

enum MockPokemonApiServiceError: String, LocalizedError {
    case genericFailure
    
    var errorDescription: String? {
        rawValue
    }
}

class MockPokemonApiService: PokemonAPIServiceProtocol {
    
    var mockPokemonListResult: Result<Gotcha.SinglePageModel, Error>!
    func getPokemonList(withUrlString urlString: String,
                        completion: @escaping ((Result<Gotcha.SinglePageModel, Error>) -> Void)) {
        completion(mockPokemonListResult)
    }
    
    var mockPokemonDetailsResult: Result<Gotcha.PokemonModel, Error>!
    func getPokemonDetails(withUrlString urlString: String,
                           completion: @escaping ((Result<Gotcha.PokemonModel, Error>) -> Void)) {
        completion(mockPokemonDetailsResult)
    }
    
    func getSpecies(withUrl url: URL,
                    completion: @escaping ((Result<Gotcha.SpeciesModel, Error>)) -> Void) {
        
    }
    
    func getEvolution(withUrl url: URL,
                      completion: @escaping ((Result<Gotcha.EvolutionModel, Error>) -> Void)) {
        
    }
    
    func getAbilityDetails(for ability: String,
                           completion: @escaping ((Result<Gotcha.AbilityModel, Error>) -> Void)) {
        
    }
}

class MockPokemonListViewModelDelegate: PokemonListViewModelDelegate {
    var getPageSuccessCalled = false
    func onGetPageSuccess() {
        getPageSuccessCalled = true
    }
    
    var getPageFailureCalled = false
    var lastErrorString = ""
    func onGetPageFailure(error: String) {
        getPageFailureCalled = true
        lastErrorString = error
    }
}

class MockPokemonDetailsViewModelDelegate: PokemonDetailsViewModelDelegate {
    var onDetailsModelFetchSuccessCalled = false
    
    func onDetailsModelFetchSuccess() {
        onDetailsModelFetchSuccessCalled = true
    }
    
    var onDetailsModelFetchFailureCalled = false
    var lastErrorString = ""
    
    func onDetailsModelFetchFailure(error: Error) {
        onDetailsModelFetchFailureCalled = true
        lastErrorString = error.localizedDescription
    }
}
