//
//  TypeDetailsViewModel.swift
//  Gotcha
//
//  Created by Majka on 07/04/2023.
//

import Foundation

protocol TypeDetailsViewModelProtocol: AnyObject {
    var delegate: TypeDetailsViewModelDelegate? { get set }
    var detailsModel: TypeModel? { get }
    func getTypeDetails()
}

protocol TypeDetailsViewModelDelegate: AnyObject {
    func onDetailsModelFetchSuccess()
    func onDetailsModelFetchFailure(error: Error)
}

class TypeDetailsViewModel: TypeDetailsViewModelProtocol {
    var delegate: TypeDetailsViewModelDelegate?
    var detailsModel: TypeModel?
    private let service: PokemonAPIServiceProtocol
    let url: URL
    
    init(service: PokemonAPIServiceProtocol, url: URL) {
        self.service = service
        self.url = url
    }
    
    func getTypeDetails() {
        service.getTypeDetails(withUrl: url) { [weak self] result in
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
