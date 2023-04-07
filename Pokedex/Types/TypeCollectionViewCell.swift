//
//  TypeCollectionViewCell.swift
//  Gotcha
//
//  Created by Majka on 31/03/2023.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = Constants.cellRadius
        containerView.applyShadow()
        // Initialization code
    }

    func configure(name: String) {
        typeLabel.text = name
        typeImage.image = UIImage(named: name)
        typeImage.applyShadow()
    }
}
