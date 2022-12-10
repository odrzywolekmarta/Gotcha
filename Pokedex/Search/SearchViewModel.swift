//
//  SearchViewModel.swift
//  Gotcha
//
//  Created by Majka on 09/12/2022.
//

import Foundation

protocol SearchViewModelProtocol: AnyObject {
    var delegate: SearchViewModelDelegate? { get set }
    var detailsModel: PokemonModel? { get }
    func getPokemonDetails(withUrlString urlString: String)
}

protocol SearchViewModelDelegate: AnyObject {
    func onDetailsModelFetchSuccess()
    func onDetailsModelFetchFailure(error: Error)
}

class SearchViewModel: SearchViewModelProtocol {
    var delegate: SearchViewModelDelegate?
    var detailsModel: PokemonModel?
    private let service = PokemonAPIService()
    
//    init(detailsModel: PokemonModel) {
//        self.detailsModel = detailsModel
//    }
    
    func getPokemonDetails(withUrlString urlString: String) {
        service.getPokemonDetails(withUrlString: urlString) { [weak self] result in
            switch result {
            case .success(let model):
                self?.detailsModel = model
                self?.delegate?.onDetailsModelFetchSuccess()
            case .failure(let error):
                self?.delegate?.onDetailsModelFetchFailure(error: error)
            }
        }
    }
    
   
}
