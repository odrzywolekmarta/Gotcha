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
        contentView.backgroundColor = UIColor(named: "CustomBeige")
        containerView.layer.cornerRadius = 25
        containerView.applyShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(name: String, imageUrlString: String) {
        pokemonImage.sd_cancelCurrentImageLoad()
        nameLabel.text = name.uppercased()
        pokemonImage.sd_setImage(with: URL(string: imageUrlString))
    }
    
}
