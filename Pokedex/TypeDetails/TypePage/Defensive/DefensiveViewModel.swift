//
//  DefensiveViewModel.swift
//  Gotcha
//
//  Created by Majka on 08/04/2023.
//

import Foundation

protocol DefensiveViewModelProtocol: AnyObject {
    var delegate: DefensiveViewModelDelegate? { get set }
    var detailsModel: TypeModel? { get }
    
    func set(model: TypeModel)
}

protocol DefensiveViewModelDelegate: AnyObject {
    func onDetailsModelSet()
}

class DefensiveViewModel: DefensiveViewModelProtocol {
    var delegate: DefensiveViewModelDelegate?
    var detailsModel: TypeModel?
    
    func set(model: TypeModel) {
        detailsModel = model
        delegate?.onDetailsModelSet()
    }
}
