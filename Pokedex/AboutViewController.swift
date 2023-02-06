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
    @IBOutlet weak var typeLabel1: UILabel!
    @IBOutlet weak var typeLabel2: UILabel!
    @IBOutlet weak var abilityButton1: UIButton!
    @IBOutlet weak var abilityButton2: UIButton!
    @IBOutlet weak var abilityButton3: UIButton!
    
    let viewModel: AboutViewModelProtocol = AboutViewModel(service: PokemonAPIService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configure()
    }
    
    func configure() {
        view.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        typeLabel1.makeRound(radius: typeLabel1.frame.height / 2)
        typeLabel2.makeRound(radius: typeLabel2.frame.height / 2)
        typeLabel1.isHidden = true
        typeLabel2.isHidden = true
        abilityButton1.titleLabel?.font = Constants.abilityButtonFont
        abilityButton2.titleLabel?.font = Constants.abilityButtonFont
        abilityButton3.titleLabel?.font = Constants.abilityButtonFont
        abilityButton1.setTitleColor(Constants.abilityButtonFontColor, for: .normal)
        abilityButton2.setTitleColor(Constants.abilityButtonFontColor, for: .normal)
        abilityButton3.setTitleColor(Constants.abilityButtonFontColor, for: .normal)
        abilityButton1.applyShadow()
        abilityButton2.applyShadow()
        abilityButton3.applyShadow()
        abilityButton1.startAnimatingPressActions()
        abilityButton2.startAnimatingPressActions()
        abilityButton3.startAnimatingPressActions()
    }
    
    func getColor(for type: String) -> UIColor {
        guard let enumCase = PokemonAPIType(rawValue: type) else {
            return .cyan
        }
        return UIColor(named: enumCase.colorName)!
    }
    
    @IBAction func abilityButtonTapped(_ sender: UIButton) {
        if let ability = sender.titleLabel?.text {
            viewModel.getAbilityDetails(for: ability)
        }
    }
    
}

//MARK: - Table View Delegate 

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
                    self.abilityButton1.setTitle(model.abilities[0].ability.name, for: .normal)
                    self.abilityButton2.isHidden = true
                    self.abilityButton3.isHidden = true
                case 2:
                    self.abilityButton1.setTitle(model.abilities[0].ability.name, for: .normal)
                    self.abilityButton2.setTitle(model.abilities[1].ability.name, for: .normal)
                    self.abilityButton3.isHidden = true
                case 3:
                    self.abilityButton1.setTitle(model.abilities[0].ability.name, for: .normal)
                    self.abilityButton2.setTitle(model.abilities[1].ability.name, for: .normal)
                    self.abilityButton3.setTitle(model.abilities[2].ability.name, for: .normal)
                default:
                    self.abilityButton1.isHidden = true
                    self.abilityButton2.isHidden = true
                    self.abilityButton3.isHidden = true
                }
                
                let numOfTypes = model.types.count
                switch numOfTypes {
                case 1:
                    self.typeLabel1.isHidden = false
                    self.typeLabel2.isHidden = false
                    self.typeLabel2.backgroundColor = .clear
                    self.typeLabel2.textColor = .clear
                    self.typeLabel1.text = model.types[0].type.name
                    let typeColor1 = self.getColor(for: model.types[0].type.name)
                    self.typeLabel1.backgroundColor = typeColor1

                case 2:
                    self.typeLabel1.isHidden = false
                    self.typeLabel2.isHidden = false
                    self.typeLabel1.text = model.types[0].type.name
                    self.typeLabel2.text = model.types[1].type.name
                    let typeColor1 = self.getColor(for: model.types[0].type.name)
                    let typeColor2 = self.getColor(for: model.types[1].type.name)
                    self.typeLabel1.backgroundColor = typeColor1
                    self.typeLabel2.backgroundColor = typeColor2
                default:
                    self.typeLabel1.isHidden = true
                    self.typeLabel2.isHidden = true
                }
                
               
            }
        }
    }
    
    func onAbilityDetailsSuccess() {
        DispatchQueue.main.async {
            if let model = self.viewModel.abilityModel {
                if model.effectEntries[0].language.name == "de" {
                    self.presentAlert(title: model.name, description: model.effectEntries[1].shortEffect)
                } else {
                    self.presentAlert(title: model.name, description: model.effectEntries[0].shortEffect)
                }
            }
        }
    }
    
    func onAbilityDetailsFailure(error: Error) {
        DispatchQueue.main.async {
            self.presentAlert(with: error)
        }
    }
    
}

