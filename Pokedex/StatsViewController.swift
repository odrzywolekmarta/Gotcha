//
//  StatsViewController.swift
//  Gotcha
//
//  Created by Majka on 13/11/2022.
//

import UIKit

class StatsViewController: UIViewController {

    let viewModel: StatsViewModelProtocol = StatsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
}

extension StatsViewController: StatsViewModelDelegate {
    func onDetailsModelSet() {
        print("stats")
        //configure UI
    }
}
