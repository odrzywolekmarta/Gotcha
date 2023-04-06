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
        // Initialization code
    }

    func configure(name: String) {
        typeLabel.text = name
        if name == "unknown" {
            typeImage.image = UIImage(systemName: "questionmark")
        } else {
            typeImage.image = UIImage(named: name)
        }
    }
}
