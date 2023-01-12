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
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var eeveeView: UIView!
    @IBOutlet var eeveeViewsCollection: [UIView]!
    @IBOutlet var eeveeButtonsCollection: [UIButton]!
    
    let viewModel: EvolutionViewModelProtocol = EvolutionViewModel()
    let router: AppRouterProtocol
    private var baseEvolutionId: String = ""
    private var firstEvolutionId: String = ""
    private var secondEvolutionId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
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
        eeveeView.isHidden = true
        for view in eeveeViewsCollection {
            view.makeRound()
            view.applyShadow()
        }
        for btn in eeveeButtonsCollection {
            btn.titleLabel?.isHidden = true
        }
    }
    
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    @IBAction func goToDetails(_ sender: UIButton) {
        if eeveeView.isHidden {
            if sender == firstButton {
                router.navigateToDetails(urlString: "\(Constants.basePokemonUrl)\(baseEvolutionId)")
            } else if sender == secondButton || sender == thirdButton {
                router.navigateToDetails(urlString: "\(Constants.basePokemonUrl)\(firstEvolutionId)")
            } else if sender == fourthButton {
                router.navigateToDetails(urlString: "\(Constants.basePokemonUrl)\(secondEvolutionId)")
            }
        } else  {
            if let id = sender.titleLabel?.text {
                router.navigateToDetails(urlString: "\(Constants.basePokemonUrl)\(id)")
                
            }
        }
    }
    

}
//MARK: - Evolution View Model Delegate

extension EvolutionViewController: EvolutionViewModelDelegate {
    func onEvolutionModelFetchSuccess() {
        DispatchQueue.main.async {
            if let evolutionArray = self.viewModel.simplifiedEvolutionSetModel?.evolutionsIdsArray {
                let eeveeIds = ["133", "134", "135", "136", "196", "197", "470", "471", "700"]
                let chainCount = self.viewModel.simplifiedEvolutionSetModel?.evolutionsIdsArray.count
                switch chainCount {
                case 1:
                    self.noEvolutionLabel.isHidden = false
                case 2:
                    self.baseEvolutionId = evolutionArray[0]
                    self.firstEvolutionId = evolutionArray[1]
                    if eeveeIds.contains(self.baseEvolutionId) {
                        self.eeveeView.isHidden = false
                    } else {
                        self.firstEvolutionStackView.isHidden = false
                        let firstUrl = self.viewModel.getPokemonImageUrl(forSpeciesId: self.viewModel.simplifiedEvolutionSetModel?.evolutionsIdsArray[0])
                        let secondUrl = self.viewModel.getPokemonImageUrl(forSpeciesId: self.viewModel.simplifiedEvolutionSetModel?.evolutionsIdsArray[1])
                        self.basePokemonImage.sd_setImage(with: firstUrl)
                        self.firstEvolutionImage.sd_setImage(with: secondUrl)
                        self.secondBasePokemonImage.sd_setImage(with: secondUrl)
                        self.secondEvolutionStackView.isHidden = true
                    }
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
                    self.baseEvolutionId = evolutionArray[0]
                    self.firstEvolutionId = evolutionArray[1]
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
