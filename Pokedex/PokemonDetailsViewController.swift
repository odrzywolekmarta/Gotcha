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
    @IBOutlet weak var favouritesButton: UIButton!
    
    let viewModel: PokemonDetailsViewModelProtocol
    let router: AppRouterProtocol
    let baseColor: UIColor = UIColor(named: Constants.Colors.customOrange)!
    private var parentNavigationBarColor: UIColor?
    private let imageViewFullHeight: CGFloat = 220
    var pageViewController: DetailsPageViewController
    private var isFavourite: Bool = false
    var favourites = Favourites()
    private var persistedPokemon = PersistedModel(id: 1, name: "")
    
    init(viewModel: PokemonDetailsViewModelProtocol, router: AppRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        self.pageViewController = DetailsPageViewController(appRouter: router)
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
        roundCornersCardView.applyShadow()
        sectionsView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        pageContainerView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        bottomView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        numberLabel.textDropShadow()
        nameLabel.textDropShadow()
        
        aboutButton.titleLabel?.textDropShadow()
        setTintColor(for: aboutButton)
        statisticsButton.titleLabel?.textDropShadow()
        evolutionButton.titleLabel?.textDropShadow()
        aboutButton.configuration?.attributedTitle?.font = UIFont(name: Constants.customFontBold, size: 19)
        statisticsButton.configuration?.attributedTitle?.font = UIFont(name: Constants.customFontBold, size: 19)
        evolutionButton.configuration?.attributedTitle?.font = UIFont(name: Constants.customFontBold, size: 19)
        aboutButton.startAnimatingPressActions()
        statisticsButton.startAnimatingPressActions()
        evolutionButton.startAnimatingPressActions()
        favouritesButton.isHidden = true
        favouritesButton.startAnimatingPressActions()
        favouritesButton.imageView?.applyShadow()
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.view.topAnchor.constraint(equalTo: pageContainerView.topAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: pageContainerView.bottomAnchor).isActive = true
        pageViewController.view.leadingAnchor.constraint(equalTo: pageContainerView.leadingAnchor).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: pageContainerView.trailingAnchor).isActive = true
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
                
        if viewModel.detailsModel != nil {
            onDetailsModelFetchSuccess()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getPokemonDetails()
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.update(backroundColor: parentNavigationBarColor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.update(backroundColor: baseColor)
        favourites.fetch()
        setFavouritesButton()
        
    }
    
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
            self.pageViewController.slideToPage(index: 0, completion: nil)
            self.setTintColor(for: self.aboutButton)
    }
    
    @IBAction func statsButtonPressed(_ sender: UIButton) {
        pageViewController.slideToPage(index: 1, completion: nil)
        setTintColor(for: statisticsButton)
    }
    
    @IBAction func evolutionButtonPressed(_ sender: UIButton) {
        pageViewController.slideToPage(index: 2, completion: nil)
        setTintColor(for: evolutionButton)
    }
    
    var pageButtons: [UIButton] {
        [aboutButton, statisticsButton, evolutionButton]
    }
    
    func setTintColor(for button: UIButton) {
        button.tintColor = UIColor(named: Constants.Colors.customRed)?.darker(by: 25)
        for pageButton in pageButtons {
            if pageButton !== button {
                pageButton.tintColor = UIColor(named: Constants.Colors.customRed)
            }
        }
    }
    
    func setFavouritesButton() {
        if favourites.contains(persistedPokemon) {
            favouritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favouritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func faveButtonPressed(_ sender: UIButton) {
        if isFavourite {
            isFavourite = false
            favouritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favourites.remove(persistedPokemon)
        } else {
            isFavourite = true
            favouritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favourites.add(persistedPokemon)
        }
    }
}


//MARK: - View Model Delegate

extension PokemonDetailsViewController: PokemonDetailsViewModelDelegate {
    func onDetailsModelFetchSuccess() {
        guard let detailsModel = viewModel.detailsModel else {
            //shouldn't happen
            return
        }
        
        pageViewController.set(model: detailsModel)
        
        DispatchQueue.main.async { [self] in
            
            self.nameLabel.text = detailsModel.name.uppercased()
            self.view.layoutIfNeeded()
            self.pokemonImageView.sd_setImage(with:
                                                detailsModel.sprites.other.officialArtwork.frontDefault) { _, _, _, _ in
                UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
                    self.pokemonImageView.alpha = 1
                    self.imageViewHeightConstraint.constant = self.imageViewFullHeight
                    self.view.layoutIfNeeded()
                    self.pokemonImageView.applyShadow()
                } completion: { _ in
                    //nothing
                }
            }
            
            self.persistedPokemon.id = detailsModel.id
            self.persistedPokemon.name = detailsModel.name
            
            if let id = self.viewModel.detailsModel?.id {
                let idString = String(id)
                let digitsInId = idString.count
                switch digitsInId {
                case 1:
                    self.numberLabel.text = "#00\(idString)"
                case 2:
                    self.numberLabel.text = "#0\(idString)"
                default:
                    self.numberLabel.text = "#\(idString)"
                }
            }
            favouritesButton.isHidden = false
            setFavouritesButton()
        }
    }
    
    func onDetailsModelFetchFailure(error: Error) {
        DispatchQueue.main.async {
            self.pokemonImageView.image = UIImage(named: "unknown")
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
                self.pokemonImageView.alpha = 1
                self.imageViewHeightConstraint.constant = self.imageViewFullHeight
                self.view.layoutIfNeeded()
                self.pokemonImageView.applyShadow()
            }
        }
        presentAlert(with: error)
    }
    
}

