//
//  AbilityDetailsViewModel.swift
//  Gotcha
//
//  Created by Majka on 18/05/2023.
//

import Foundation

protocol AbilityDetailsViewModelProtocol: AnyObject {
    var delegate: AbilityDetailsViewModelDelegate? { get set }
    var detailsModel: AbilityModel { get }
}

protocol AbilityDetailsViewModelDelegate: AnyObject {
    
}

class AbilityDetailsViewModel: AbilityDetailsViewModelProtocol {
    var delegate: AbilityDetailsViewModelDelegate?
    var detailsModel: AbilityModel
    
    init(detailsModel: AbilityModel) {
        self.detailsModel = detailsModel
    }
}
