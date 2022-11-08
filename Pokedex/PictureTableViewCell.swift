//
//  PictureTableViewCell.swift
//  Pokedex
//
//  Created by Majka on 08/11/2022.
//

import UIKit

class PictureTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(imageUrlString: String) {
        pokemonImage.sd_setImage(with: URL(string: imageUrlString))
    }
    
}
