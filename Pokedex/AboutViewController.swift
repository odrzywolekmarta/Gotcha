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
    @IBOutlet weak var typeButton1: UIButton!
    @IBOutlet weak var typeButton2: UIButton!
    @IBOutlet weak var abilityButton1: UIButton!
    @IBOutlet weak var abilityButton2: UIButton!
    @IBOutlet weak var abilityButton3: UIButton!
    @IBOutlet weak var typeImage1: UIImageView!
    @IBOutlet weak var typeImage2: UIImageView!
    @IBOutlet weak var type2StackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let viewModel: AboutViewModelProtocol = AboutViewModel(service: PokemonAPIService())
    private let router: AppRouterProtocol

    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configure()
    }
    
    func configure() {
        view.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        typeImage1.isHidden = true
        typeImage2.isHidden = true
        type2StackView.isHidden = true
        
        let abilityButtons = [abilityButton1, abilityButton2, abilityButton3]
        for button in abilityButtons {
            button?.titleLabel?.font = Constants.abilityButtonFont
            button?.backgroundColor = UIColor(named: Constants.Colors.customRed)?.withAlphaComponent(0.15)
            button?.makeRound(radius: 15)
            button?.applyShadow()
            button?.startAnimatingPressActions()
        }
        
        let typeButtons = [typeButton1, typeButton2]
        for button in typeButtons {
            button?.isHidden = true
            button?.titleLabel?.font = Constants.abilityButtonFont
            button?.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            button?.makeRound(radius: 15)
            button?.applyShadow()
            button?.startAnimatingPressActions()
        }
        
        typeImage1.applyShadow()
        typeImage2.applyShadow()
    }
    
    @IBAction func abilityButtonTapped(_ sender: UIButton) {
        if let ability = sender.titleLabel?.text {
            viewModel.getAbilityDetails(for: ability)
        }
    }
    
    @IBAction func typeButtonTapped(_ sender: UIButton) {
        if let type = sender.titleLabel?.text {
            viewModel.getTypeDetails(forType: type)
        }
    }
    
    
}

//MARK: - Table View Delegate 

extension AboutViewController: AboutViewModelDelegate {
    func onTypeDetailsModelFetchSuccess() {
        DispatchQueue.main.async {
            if let model = self.viewModel.typeModel {
                self.router.navigateToType(withModel: model)
            }
        }
    }
    
    func onTypeDetailsModelFetchFailure(error: Error) {
        DispatchQueue.main.async {
            self.presentAlert(with: error)
            debugPrint(error)
        }
    }
    
    func onDetailsModelSet() {
        DispatchQueue.main.async {
            if let species = self.viewModel.speciesModel {
                let englishDescriptions = species.flavorTextEntries.filter { text in
                    text?.language?.name == "en"
                }
                
                if englishDescriptions.count > 0 {
                    let blackDescription = englishDescriptions.filter { text in
                        text?.version?.name == "black"
                    }
                    
                    if blackDescription.count != 0 {
                        self.descriptionLabel.text = blackDescription[0]?.flavorText?.removeNewLines()
                    } else {
                        self.descriptionLabel.text = englishDescriptions[0]?.flavorText?.removeNewLines()
                    }
                } else {
                    self.descriptionLabel.text = Constants.noPokemonDescription
                }

            }
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
                    let type1 = model.types[0].type.name
                    self.typeButton1.isHidden = false
                    self.typeButton2.isHidden = false
                    self.typeImage1.isHidden = false
                    self.typeButton1.setTitle(type1, for: .normal)
                    self.typeImage1.image = UIImage(named: type1)
                case 2:
                    let type1 = model.types[0].type.name
                    let type2 = model.types[1].type.name
                    self.typeImage1.isHidden = false
                    self.typeImage2.isHidden = false
                    self.typeButton1.isHidden = false
                    self.typeButton2.isHidden = false
                    self.type2StackView.isHidden = false
                    self.typeButton1.setTitle(type1, for: .normal)
                    self.typeButton2.setTitle(type2, for: .normal)
                    self.typeImage1.image = UIImage(named: type1)
                    self.typeImage2.image = UIImage(named: type2)
                default:
                    self.typeButton1.isHidden = true
                    self.typeButton2.isHidden = true
                }
                
               
            }
        }
    }
    
    func onAbilityDetailsSuccess() {
        DispatchQueue.main.async {
            if let model = self.viewModel.abilityModel {
                let englishDescription = model.effectEntries.filter { description in
                    description.language.name == "en"
                }
                
                if englishDescription.count == 0 {
                    self.presentAlert(title: model.name, description: Constants.noAbilityDescription)
                } else {
                    self.presentAlert(title: model.name, description: englishDescription[0].shortEffect)
                }
            }
        }
    }
    
    func onAbilityDetailsFailure(error: Error) {
        DispatchQueue.main.async {
            self.presentAlert(with: error)
            debugPrint(error)
        }
    }
    
}

