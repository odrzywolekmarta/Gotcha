//
//  AbilitiesTableViewCell.swift
//  Pokedex
//
//  Created by Majka on 07/11/2022.
//

import UIKit

class AbilitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var abilityLabel1: UILabel!
    @IBOutlet weak var abilityLabel2: UILabel!
    @IBOutlet weak var abilityLabel3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .cyan
    }
    
    func configure(ability1: String, ability2: String, ability3: String) {
        abilityLabel1.text = ability1
        abilityLabel2.text = ability2
        abilityLabel3.text = ability3
    }
}
