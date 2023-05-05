//
//  TypesViewModel.swift
//  Gotcha
//
//  Created by Majka on 30/03/2023.
//

import Foundation

protocol TypesViewModelProtocol: AnyObject {
    var delegate: TypesViewModelDelegate? { get set }
    var types: [Results] { get }
    var pokeballs: [Items] { get }
    func getPokemonTypes()
    func getPokeballList()
}

protocol TypesViewModelDelegate: AnyObject {
    func onTypesFetchSuccess()
    func onTypesFetchFailure(error: String)
    func onPokeballFetchSuccess()
    func onPokeballFetchFailure(error: String)
}

class TypesViewModel: TypesViewModelProtocol {
    var delegate: TypesViewModelDelegate?
    private let urlString = Constants.typesUrl
    private let firstPokeballUrl = Constants.standardBallsUrl
    private let secondPokeballUrl = Constants.specialBallsUrl
    private let thirdPokeballUrl = Constants.apricornBallsUrl
    private let service: PokemonAPIServiceProtocol
    var types: [Results] = []
    var pokeballs: [Items] = []
    
    
    init(service: PokemonAPIServiceProtocol) {
        self.service = service
    }
    
    func getPokemonTypes() {
        service.getPokemonList(withUrlString: urlString) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.onTypesFetchFailure(error: error.localizedDescription)
            case .success(let data):
                self?.types.append(contentsOf: data.results)
                self?.delegate?.onTypesFetchSuccess()
            }
        }
    }
    
    func getPokeballList() {
        let group = DispatchGroup()
        var firstSuccess = false
        var secondSuccess = false
        var thirdSuccess = false
        
        group.enter()
        service.getItemsList(withUrlString: firstPokeballUrl) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.onPokeballFetchFailure(error: error.localizedDescription)
                firstSuccess = false
            case .success(let data):
                self?.pokeballs.append(contentsOf: data.items)
                firstSuccess = true
            }
            group.leave()
        }

        group.enter()
        service.getItemsList(withUrlString: secondPokeballUrl) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.onPokeballFetchFailure(error: error.localizedDescription)
                secondSuccess = false
            case .success(let data):
                self?.pokeballs.append(contentsOf: data.items)
                secondSuccess = true
            }
            group.leave()
        }
        
        group.enter()
        service.getItemsList(withUrlString: thirdPokeballUrl) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.onPokeballFetchFailure(error: error.localizedDescription)
                thirdSuccess = false
            case .success(let data):
                thirdSuccess = true
                self?.pokeballs.append(contentsOf: data.items)
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            if firstSuccess == true || secondSuccess == true || thirdSuccess == true {
                self.delegate?.onPokeballFetchSuccess()
            }
        }
        
    }
}
