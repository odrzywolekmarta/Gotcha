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
    
    func configure(with model: PokemonModel?) {
        guard let model = model else {
            return
        }
        let count = model.abilities.count
        
        if count > 0 {
            abilityLabel1.text = model.abilities[0].ability.name
            
        }
        
        if count > 1 {
            abilityLabel2.text = model.abilities[1].ability.name
        }
        
        if count > 2 {
            abilityLabel3.text = model.abilities[2].ability.name
        }
    }
}
