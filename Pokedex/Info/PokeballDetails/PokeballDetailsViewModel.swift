//
//  PokeballDetailsViewModel.swift
//  Gotcha
//
//  Created by Majka on 08/05/2023.
//

import Foundation

protocol PokeballDetailsViewModelProtocol: AnyObject {
    var delegate: PokeballDetailsViewModelDelegate? { get set }
    var detailsModel: PokeballModel { get }
}

protocol PokeballDetailsViewModelDelegate: AnyObject {
    
}

class PokeballDetailsViewModel: PokeballDetailsViewModelProtocol {
    var delegate: PokeballDetailsViewModelDelegate?
    var detailsModel: PokeballModel
    
    init(detailsModel: PokeballModel) {
        self.detailsModel = detailsModel
    }
}
