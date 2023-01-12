//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Majka on 06/11/2022.
//

import UIKit
import SDWebImage

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        containerView.layer.cornerRadius = Constants.cellRadius
        containerView.applyShadow()
    }
    
    func configure(name: String, imageUrlString: String) {
        pokemonImage.sd_cancelCurrentImageLoad()
        nameLabel.text = name.uppercased()
        pokemonImage.sd_setImage(with: URL(string: imageUrlString))
    }
    
}
