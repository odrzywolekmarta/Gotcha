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
    
}
