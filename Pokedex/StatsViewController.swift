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
    private var hpValue: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureView()
    }
    
    func configureView() {
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
                let maxHp: Float = 255
                let maxAttack: Float = 190
                let maxDefense: Float = 250
                let maxSpecialAttack: Float = 194
                let maxSpecialDefense: Float = 250
                let maxSpeed: Float = 200
                
                self.hpValue = hpValue
                self.hpBar.setProgress(hpValue / maxHp, animated: false)
                self.hpValueLabel.text = String(Int(hpValue))
                let attackValue = Float(model.stats[1].baseStat)
                self.attackBar.setProgress(attackValue / maxAttack, animated: false)
                self.attackValueLabel.text = String(Int(attackValue))
                let defenseValue = Float(model.stats[2].baseStat)
                self.defenseBar.setProgress(defenseValue / maxDefense, animated: false)
                self.defenseValueLabel.text = String(Int(defenseValue))
                let specialAttackValue = Float(model.stats[3].baseStat)
                self.specialAttackBar.setProgress(specialAttackValue / maxSpecialAttack, animated: false)
                self.specialAttackValueLabel.text = String(Int(specialAttackValue))
                let specialDefenseValue = Float(model.stats[4].baseStat)
                self.specialDefenseBar.setProgress(specialDefenseValue / maxSpecialDefense, animated: false)
                self.specialfDefenseValueLabel.text = String(Int(specialDefenseValue))
                let speedValue = Float(model.stats[5].baseStat)
                self.speedBar.setProgress(speedValue / maxSpeed, animated: false)
                self.speedValueLabel.text = String(Int(speedValue))
                let total = hpValue + attackValue + defenseValue + specialAttackValue + specialDefenseValue + speedValue
                self.totalValueLabel.text = String(Int(total))
            }
        }
    }
}
