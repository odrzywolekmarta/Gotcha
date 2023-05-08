//
//  TypesViewModel.swift
//  Gotcha
//
//  Created by Majka on 30/03/2023.
//

import Foundation

protocol InfoViewModelProtocol: AnyObject {
    var delegate: InfoViewModelDelegate? { get set }
    var types: [Results] { get }
    var pokeballs: [Items] { get }
    var typeDetails: TypeModel? { get }
    var pokeballDetails: PokeballModel? { get }
    func getPokemonTypes()
    func getPokeballList()
    func getTypeDetails(forId: Int)
    func getPokeballDetails(forName name: String)
}

protocol InfoViewModelDelegate: AnyObject {
    func onTypeDetailsModelFetchSuccess()
    func onTypeDetailsModelFetchFailure(error: Error)
    func onTypesFetchSuccess()
    func onTypesFetchFailure(error: Error)
    func onPokeballFetchSuccess()
    func onPokeballFetchFailure(error: Error)
    func onPokeballDetailsFetchSuccess()
    func onPokeballDetailsFetchFailure(error: Error)
}

class InfoViewModel: InfoViewModelProtocol {
    var delegate: InfoViewModelDelegate?
    private let urlString = Constants.typesUrl
    private let firstPokeballUrl = Constants.standardBallsUrl
    private let secondPokeballUrl = Constants.specialBallsUrl
    private let thirdPokeballUrl = Constants.apricornBallsUrl
    private let service: PokemonAPIServiceProtocol
    var url: URL?
    var typeDetails: TypeModel?
    var pokeballDetails: PokeballModel?
    var types: [Results] = []
    var pokeballs: [Items] = []
    var typeBaseUrl = "https://pokeapi.co/api/v2/type/"
    
    
    init(service: PokemonAPIServiceProtocol) {
        self.service = service
    }
    
    func getPokemonTypes() {
        service.getPokemonList(withUrlString: urlString) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.onTypesFetchFailure(error: error)
            case .success(let data):
                self?.types.append(contentsOf: data.results)
                self?.delegate?.onTypesFetchSuccess()
            }
        }
    }
    
    func getTypeDetails(forId id: Int) {
        if let url = URL(string: "https://pokeapi.co/api/v2/type/\(id)") {
            service.getTypeDetails(withUrl: url) { [weak self] result in
                switch result {
                case .success(let model):
                    self?.typeDetails = model
                    self?.delegate?.onTypeDetailsModelFetchSuccess()
                case .failure(let error):
                    self?.delegate?.onTypeDetailsModelFetchFailure(error: error)
                }
            }
        }
    }
    
    func getPokeballDetails(forName name: String) {
        service.getPokeballDetails(withName: name) { result in
            switch result {
            case .success(let model):
                self.pokeballDetails = model
                self.delegate?.onPokeballDetailsFetchSuccess()
            case .failure(let error):
                self.delegate?.onPokeballDetailsFetchFailure(error: error)
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
                self?.delegate?.onPokeballFetchFailure(error: error)
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
                self?.delegate?.onPokeballFetchFailure(error: error)
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
                self?.delegate?.onPokeballFetchFailure(error: error)
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
