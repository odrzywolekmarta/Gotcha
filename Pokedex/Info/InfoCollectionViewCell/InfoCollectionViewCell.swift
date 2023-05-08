//
//  TypeCollectionViewCell.swift
//  Gotcha
//
//  Created by Majka on 31/03/2023.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = Constants.cellRadius
        containerView.applyShadow()
        // Initialization code
    }

    func configureWithType(name: String) {
        typeLabel.text = name
        typeImage.image = UIImage(named: name)
        typeImage.applyShadow()
    }
    
    func configureWithPokeball(name: String) {
        let pokeballName = name.replacingOccurrences(of: "-", with: " ", options: .literal)
        typeLabel.text = pokeballName
        if let imageUrl = URL(string: "\(Constants.basePokeballImageUrl)\(name).png") {
            typeImage.sd_setImage(with: imageUrl)
        }
        typeImage.applyShadow()
    }
}
