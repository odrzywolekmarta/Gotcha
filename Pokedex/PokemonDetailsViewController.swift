//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Majka on 06/11/2022.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameSectionContainerView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var roundCornersCardView: UIView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var sectionsView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var statisticsButton: UIButton!
    @IBOutlet weak var evolutionButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    

    let viewModel: PokemonDetailsViewModelProtocol
    let router: AppRouterProtocol
    let baseColor: UIColor = UIColor(named: Constants.Colors.customOrange)!

    init(viewModel: PokemonDetailsViewModelProtocol, router: AppRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        navigationController?.navigationBar.update(backroundColor: baseColor, titleColor: baseColor)
        
        view.backgroundColor = baseColor
        nameSectionContainerView.backgroundColor = baseColor
        imageBackgroundView.backgroundColor = baseColor
        roundCornersCardView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        roundCornersCardView.makeRound(radius: 50)
        sectionsView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        collectionView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        bottomView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getPokemonDetails()
        configureView()
    }
}


//MARK: - View Model Delegate

extension PokemonDetailsViewController: PokemonDetailsViewModelDelegate {
    func onDetailsModelFetchSuccess() {
        DispatchQueue.main.async {
        }
    }

    func onDetailsModelFetchFailure(error: String) {
        DispatchQueue.main.async {
        }
        print(error)
    }
}

