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
    @IBOutlet weak var pageContainerView: UIView!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var statisticsButton: UIButton!
    @IBOutlet weak var evolutionButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    

    let viewModel: PokemonDetailsViewModelProtocol
    let router: AppRouterProtocol
    let baseColor: UIColor = UIColor(named: Constants.Colors.customOrange)!
    private var parentNavigationBarColor: UIColor?
    private let imageViewFullHeight: CGFloat = 220
    var pageViewController = DetailsPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    init(viewModel: PokemonDetailsViewModelProtocol, router: AppRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        parentNavigationBarColor = navigationController?.navigationBar.standardAppearance.backgroundColor
        navigationController?.navigationBar.update(backroundColor: baseColor, titleColor: baseColor)
        view.backgroundColor = baseColor
        nameSectionContainerView.backgroundColor = baseColor
        imageBackgroundView.backgroundColor = baseColor
        roundCornersCardView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        roundCornersCardView.makeRound(radius: 50)
        sectionsView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        pageContainerView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        bottomView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        
        addChild(pageViewController)
        pageViewController.view.frame = pageContainerView.frame
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        _ = pageViewController.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getPokemonDetails()
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.update(backroundColor: parentNavigationBarColor, titleColor: parentNavigationBarColor)
    }
}


//MARK: - View Model Delegate

extension PokemonDetailsViewController: PokemonDetailsViewModelDelegate {
    func onDetailsModelFetchSuccess() {
        DispatchQueue.main.async {
            
                self.nameLabel.text = self.viewModel.detailsModel?.name.uppercased()
                self.pokemonImageView.sd_setImage(with:
                                                    self.viewModel.detailsModel?.sprites.other.officialArtwork.frontDefault) { _, _, _, _ in
                    UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
                        self.pokemonImageView.alpha = 1
                        self.imageViewHeightConstraint.constant = self.imageViewFullHeight
                        self.view.layoutIfNeeded()
                 
                    } completion: { _ in
//                        UIView.animate(withDuration: 0.1) {
//                            let backgroundColor = self.pokemonImageView.image?.getAverageColour?.lighter(by: 300)
//                            self.navigationController?.navigationBar.update(backroundColor: backgroundColor, titleColor: backgroundColor)
//                            self.view.backgroundColor = backgroundColor
//                            self.nameSectionContainerView.backgroundColor = backgroundColor
//                            self.imageBackgroundView.backgroundColor = backgroundColor
//                        }
                    }
                }
            
                if let id = self.viewModel.detailsModel?.id {
                    self.numberLabel.text = String(id)
            }
        }
    }

    func onDetailsModelFetchFailure(error: String) {
        DispatchQueue.main.async {
        }
        print(error)
    }
}

