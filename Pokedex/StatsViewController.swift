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
        hpBar.applyShadow()
        attackBar.applyShadow()
        defenseBar.applyShadow()
        specialAttackBar.applyShadow()
        specialDefenseBar.applyShadow()
        speedBar.applyShadow()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Stats View Model Delegate

extension StatsViewController: StatsViewModelDelegate {
    func onDetailsModelSet() {
        DispatchQueue.main.async {
            if let model = self.viewModel.detailsModel {
                let hpValue = Double(model.stats[0].baseStat / 255)
                self.hpBar.setProgress(0.8, animated: false)
                print(model.stats)
                print(model.stats[0].baseStat)
            }
                }
    }
}
