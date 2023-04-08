//
//  DefensiveViewController.swift
//  Gotcha
//
//  Created by Majka on 08/04/2023.
//

import UIKit

class DefensiveViewController: UIViewController {
    
    let viewModel: DefensiveViewModelProtocol = DefensiveViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }

}

extension DefensiveViewController: DefensiveViewModelDelegate {
    func onDetailsModelSet() {
        DispatchQueue.main.async {
            
        }
    }
}
