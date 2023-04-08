//
//  OffensiveViewController.swift
//  Gotcha
//
//  Created by Majka on 08/04/2023.
//

import UIKit

class OffensiveViewController: UIViewController {
    
    let viewModel: OffensiveViewModelProtocol = OffensiveViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
}

extension OffensiveViewController: OffensiveViewModelDelegate {
    func onDetailsModelSet() {
        DispatchQueue.main.async {
            
        }
    }
}
