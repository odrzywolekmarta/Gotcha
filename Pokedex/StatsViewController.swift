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
            if let model = self.viewModel.detailsModel {
                let hpValue = Float(model.stats[0].baseStat / 255)
                print(hpValue)
                self.hpBar.setProgress(hpValue, animated: true)
            }
                }
    }
}
