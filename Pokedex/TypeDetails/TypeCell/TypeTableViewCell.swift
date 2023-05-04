//
//  TypeTableViewCell.swift
//  Gotcha
//
//  Created by Majka on 04/05/2023.
//

import UIKit

class TypeTableViewCell: UITableViewCell {

    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(name: String) {
        typeLabel.text = name
        typeImageView.image = UIImage(named: name)
        typeImageView.applyShadow()
    }
    
}
