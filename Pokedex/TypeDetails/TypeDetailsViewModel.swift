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
    
}

protocol TypeDetailsViewModelDelegate: AnyObject {
    func onDetailsModelFetchSuccess()
    func onDetailsModelFetchFailure(error: Error)
}

class TypeDetailsViewModel: TypeDetailsViewModelProtocol {
    var delegate: TypeDetailsViewModelDelegate?
    var detailsModel: TypeModel?
    
}
