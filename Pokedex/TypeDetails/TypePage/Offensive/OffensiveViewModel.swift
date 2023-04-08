//
//  OffensiveViewModel.swift
//  Gotcha
//
//  Created by Majka on 08/04/2023.
//

import Foundation

protocol OffensiveViewModelProtocol: AnyObject {
    var delegate: OffensiveViewModelDelegate? { get set }
    var detailsModel: TypeModel? { get }
    
    func set(model: TypeModel)
}

protocol OffensiveViewModelDelegate: AnyObject {
    func onDetailsModelSet()
}

class OffensiveViewModel: OffensiveViewModelProtocol {
    var delegate: OffensiveViewModelDelegate?
    var detailsModel: TypeModel?
    
    func set(model: TypeModel) {
        detailsModel = model
        delegate?.onDetailsModelSet()
    }    
}
