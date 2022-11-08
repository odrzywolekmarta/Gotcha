//
//  TypesTableViewCell.swift
//  Pokedex
//
//  Created by Majka on 08/11/2022.
//

import UIKit

class TypesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel1: UILabel!
    @IBOutlet weak var typeLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: PokemonModel?) {
        guard let model = model else {
            return
        }
        let count = model.types.count
        
        if count > 0 {
            typeLabel1.text = model.types[0].type.name
        }
        if count > 1 {
            typeLabel2.text = model.types[1].type.name
        }
        
    }
}
