//
//  AboutViewController.swift
//  Gotcha
//
//  Created by Majka on 13/11/2022.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    let viewModel: AboutViewModelProtocol = AboutViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        
    }
}

extension AboutViewController: AboutViewModelDelegate {
    func onDetailsModelSet() {
        DispatchQueue.main.async {
            if let model = self.viewModel.detailsModel {
                let doubleWeight = Double(model.weight)
                let labelWeight = String(doubleWeight / 10)
                self.weightLabel.text = "\(labelWeight) kg"
                
                let doubleHeight = Double(model.height)
                switch doubleHeight {
                case 1...9:
                    let labelHeight = String(model.height * 10)
                    self.heightLabel.text = "\(labelHeight) cm"
                case 10...99:
                    let labelHeight = String(doubleHeight / 10)
                    self.heightLabel.text = "\(labelHeight) m"
                default:
                    let labelHeight = String(doubleHeight / 10)
                    self.heightLabel.text = "\(labelHeight) m"
                }
                
                let numOfAbilities = model.abilities.count
                switch numOfAbilities {
                case 1:
                    self.
                default:
                    <#code#>
                }
                
            }
        }
    }
}
