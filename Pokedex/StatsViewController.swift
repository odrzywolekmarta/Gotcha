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
    @IBOutlet weak var hpValueLabel: UILabel!
    @IBOutlet weak var attackValueLabel: UILabel!
    @IBOutlet weak var defenseValueLabel: UILabel!
    @IBOutlet weak var specialAttackValueLabel: UILabel!
    @IBOutlet weak var specialfDefenseValueLabel: UILabel!
    @IBOutlet weak var speedValueLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    
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
                let hpValue = Float(model.stats[0].baseStat)
                self.hpBar.setProgress(hpValue / 255, animated: false)
                self.hpValueLabel.text = String(Int(hpValue))
                let attackValue = Float(model.stats[1].baseStat)
                self.attackBar.setProgress(attackValue / 190, animated: false)
                self.attackValueLabel.text = String(Int(attackValue))
                let defenseValue = Float(model.stats[2].baseStat)
                self.defenseBar.setProgress(defenseValue / 250, animated: false)
                self.defenseValueLabel.text = String(Int(defenseValue))
                let specialAttackValue = Float(model.stats[3].baseStat)
                self.specialAttackBar.setProgress(specialAttackValue / 194, animated: false)
                self.specialAttackValueLabel.text = String(Int(specialAttackValue))
                let specialDefenseValue = Float(model.stats[4].baseStat)
                self.specialDefenseBar.setProgress(specialDefenseValue / 250, animated: false)
                self.specialfDefenseValueLabel.text = String(Int(specialDefenseValue))
                let speedValue = Float(model.stats[5].baseStat)
                self.speedBar.setProgress(speedValue / 200, animated: false)
                self.speedValueLabel.text = String(Int(speedValue))
                let total = hpValue + attackValue + defenseValue + specialAttackValue + specialDefenseValue + speedValue
                self.totalValueLabel.text = String(Int(total))
            }
                }
    }
}
