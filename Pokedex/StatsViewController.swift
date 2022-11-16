//
//  StatsViewController.swift
//  Gotcha
//
//  Created by Majka on 13/11/2022.
//

import UIKit

class StatsViewController: UIViewController {

    @IBOutlet weak var hpBar: UIProgressView!
    @IBOutlet weak var attackBar: UIProgressView!
    @IBOutlet weak var defenseBar: UIProgressView!
    @IBOutlet weak var specialAttackBar: UIProgressView!
    @IBOutlet weak var specialDefenseBar: UIProgressView!
    @IBOutlet weak var speedBar: UIProgressView!
    
    let viewModel: StatsViewModelProtocol = StatsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
}

//MARK: - Stats View Model Delegate

extension StatsViewController: StatsViewModelDelegate {
    func onDetailsModelSet() {
        DispatchQueue.main.async {
           
        
        }
    }
}
