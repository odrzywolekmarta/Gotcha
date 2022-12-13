//
//  EvolutionViewController.swift
//  Gotcha
//
//  Created by Majka on 13/11/2022.
//

import UIKit

class EvolutionViewController: UIViewController {
    
    @IBOutlet weak var basePokemonImage: UIImageView!
    @IBOutlet weak var firstEvolutionImage: UIImageView!
    @IBOutlet weak var secondBasePokemonImage: UIImageView!
    @IBOutlet weak var secondEvolutionImage: UIImageView!
    @IBOutlet weak var firstEvolutionStackView: UIStackView!
    @IBOutlet weak var secondEvolutionStackView: UIStackView!
    @IBOutlet weak var noEvolutionLabel: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourthView: UIView!
    
    let viewModel: EvolutionViewModelProtocol = EvolutionViewModel()
    let router: AppRouterProtocol
    var firstEvolutionId: String = ""
    var secondEvolutionId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstEvolutionStackView.isHidden = true
        secondEvolutionStackView.isHidden = true
        noEvolutionLabel.isHidden = true
        noEvolutionLabel.applyShadow()
        firstView.makeRound()
        firstView.applyShadow()
        secondView.makeRound()
        secondView.applyShadow()
        thirdView.makeRound()
        thirdView.applyShadow()
        fourthView.makeRound()
        fourthView.applyShadow()
    }
    
   
    
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func evolutionButtonPressed(_ sender: Any) {
        
    }
}


//MARK: - Evolution View Model Delegate

extension EvolutionViewController: EvolutionViewModelDelegate {
    func onEvolutionModelFetchSuccess() {
        DispatchQueue.main.async {
            if let evolutionArray = self.viewModel.simplifiedEvolutionSetModel?.evolutionsIdsArray {
                let chainCount = self.viewModel.simplifiedEvolutionSetModel?.evolutionsIdsArray.count
                switch chainCount {
                case 1:
                    self.noEvolutionLabel.isHidden = false
                case 2:
                    self.firstEvolutionStackView.isHidden = false
                    let firstUrl = self.viewModel.getPokemonImageUrl(forSpeciesId: self.viewModel.simplifiedEvolutionSetModel?.evolutionsIdsArray[0])
                    let secondUrl = self.viewModel.getPokemonImageUrl(forSpeciesId: self.viewModel.simplifiedEvolutionSetModel?.evolutionsIdsArray[1])
                    self.basePokemonImage.sd_setImage(with: firstUrl)
                    self.firstEvolutionImage.sd_setImage(with: secondUrl)
                    self.secondBasePokemonImage.sd_setImage(with: secondUrl)
                    self.secondEvolutionStackView.isHidden = true
                    self.firstEvolutionId = evolutionArray[1]
                case 3:
                    self.firstEvolutionStackView.isHidden = false
                    self.secondEvolutionStackView.isHidden = false
                    let firstUrl = self.viewModel.getPokemonImageUrl(forSpeciesId: self.viewModel.simplifiedEvolutionSetModel?.evolutionsIdsArray[0])
                    let secondUrl = self.viewModel.getPokemonImageUrl(forSpeciesId: self.viewModel.simplifiedEvolutionSetModel?.evolutionsIdsArray[1])
                    let thirdUrl = self.viewModel.getPokemonImageUrl(forSpeciesId: self.viewModel.simplifiedEvolutionSetModel?.evolutionsIdsArray[2])
                    self.basePokemonImage.sd_setImage(with: firstUrl)
                    self.firstEvolutionImage.sd_setImage(with: secondUrl)
                    self.secondBasePokemonImage.sd_setImage(with: secondUrl)
                    self.secondEvolutionImage.sd_setImage(with: thirdUrl)
                    self.secondEvolutionId = evolutionArray[2]
                default:
                    self.secondEvolutionStackView.isHidden = true
                    self.firstEvolutionStackView.isHidden = true
                }
            }
        }
    }
    
    func onEvolutionModelFetchFailure(error: String) {
        DispatchQueue.main.async {
        }
        print(error)
    }
    
}
