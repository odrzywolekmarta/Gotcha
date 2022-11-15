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
    @IBOutlet weak var abilityLabel1: UILabel!
    @IBOutlet weak var abilityLabel2: UILabel!
    @IBOutlet weak var abilityLabel3: UILabel!
    @IBOutlet weak var typeLabel1: UILabel!
    @IBOutlet weak var typeLabel2: UILabel!
    
    let viewModel: AboutViewModelProtocol = AboutViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        typeLabel1.makeRound(radius: 12)
        typeLabel2.makeRound(radius: 14)
    }
}

func getColor(for type: String) -> UIColor {
    let pokemonType = type
    switch pokemonType {
    case "normal":
        return UIColor(named: Constants.Colors.normalType)!
    case "fire":
        return UIColor(named: Constants.Colors.fireType)!
    case "water":
        return UIColor(named: Constants.Colors.waterType)!
    case "grass":
        return UIColor(named: Constants.Colors.grassType)!
    case "electric":
        return UIColor(named: Constants.Colors.electricType)!
    case "ice":
        return UIColor(named: Constants.Colors.iceType)!
    case "fighting":
        return UIColor(named: Constants.Colors.fightingType)!
    case "poison":
        return UIColor(named: Constants.Colors.poisonType)!
    case "ground":
        return UIColor(named: Constants.Colors.groundType)!
    case "flying":
        return UIColor(named: Constants.Colors.flyingType)!
    case "psychic":
        return UIColor(named: Constants.Colors.psychicType)!
    case "bug":
        return UIColor(named: Constants.Colors.bugType)!
    case "rock":
        return UIColor(named: Constants.Colors.rockType)!
    case "ghost":
        return UIColor(named: Constants.Colors.ghostType)!
    case "dark":
        return UIColor(named: Constants.Colors.darkType)!
    case "dragon":
        return UIColor(named: Constants.Colors.dragonType)!
    case "steel":
        return UIColor(named: Constants.Colors.steelType)!
    case "fairy":
        return UIColor(named: Constants.Colors.fairyType)!
    default:
        return UIColor(named: Constants.Colors.normalType)!
    }
}

//MARK: - Table View Delegate Methods

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
                    self.abilityLabel1.text = model.abilities[0].ability.name
                    self.abilityLabel2.isHidden = true
                    self.abilityLabel3.isHidden = true
                case 2:
                    self.abilityLabel1.text = model.abilities[0].ability.name
                    self.abilityLabel2.text = model.abilities[1].ability.name
                    self.abilityLabel3.isHidden = true
                case 3:
                    self.abilityLabel1.text = model.abilities[0].ability.name
                    self.abilityLabel2.text = model.abilities[1].ability.name
                    self.abilityLabel3.text = model.abilities[2].ability.name
                default:
                    self.abilityLabel1.isHidden = true
                    self.abilityLabel2.isHidden = true
                    self.abilityLabel3.isHidden = true
                }
                
                let numOfTypes = model.types.count
                switch numOfTypes {
                case 1:
                    self.typeLabel1.text = model.types[0].type.name
                    let typeColor1 = getColor(for: model.types[0].type.name)
                    self.typeLabel1.backgroundColor = typeColor1
//                    self.typeLabel2.text = "label"
                    self.typeLabel2.textColor = .clear
                    self.typeLabel2.backgroundColor = .clear
                case 2:
                    self.typeLabel1.text = model.types[0].type.name
                    self.typeLabel2.text = model.types[1].type.name
                    let typeColor1 = getColor(for: model.types[0].type.name)
                    let typeColor2 = getColor(for: model.types[1].type.name)
                    self.typeLabel1.backgroundColor = typeColor1
                    self.typeLabel2.backgroundColor = typeColor2
                default:
                    self.typeLabel1.isHidden = true
                    self.typeLabel2.isHidden = true
                }
                
               
            }
        }
    }
}

