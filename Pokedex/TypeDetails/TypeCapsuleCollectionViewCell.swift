//
//  TypeCapsuleCollectionViewCell.swift
//  Gotcha
//
//  Created by Majka on 08/04/2023.
//

import UIKit

class TypeCapsuleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.makeRound()
    }

    func getTypeColor(for type: String) -> UIColor {
        guard let enumCase = PokemonAPIType(rawValue: type) else {
            return .cyan
        }
        return UIColor(named: enumCase.colorName) ?? UIColor.cyan
    }
    
    func configure(name: String) {
        typeLabel.text = name
        let backgroundColor = getTypeColor(for: name)
        containerView.backgroundColor = backgroundColor
    }
}
