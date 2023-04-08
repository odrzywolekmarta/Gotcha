//
//  TypeDetailsViewController.swift
//  Gotcha
//
//  Created by Majka on 07/04/2023.
//

import UIKit

class TypeDetailsViewController: UIViewController {
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var pokemonListButton: UIButton!
    @IBOutlet weak var pageContainerView: UIView!
    
    let viewModel: TypeDetailsViewModelProtocol
    let router: AppRouterProtocol
    var tables: [UITableView] = []
    var pageViewController: UIPageViewController
    
    init(viewModel: TypeDetailsViewModelProtocol, router: AppRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        self.pageViewController = TypePageViewController(appRouter: router)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getTypeDetails()
        configureView()
    }

    
    func configureView() {
        roundedView.makeRound(radius: 30)
        
        typeNameLabel.textDropShadow()
        typeImageView.applyShadow()
        
        backButton.applyShadow()
        backButton.configuration?.attributedTitle?.font = UIFont(name: Constants.customFontBold, size: 19)
        backButton.startAnimatingPressActions()
        
        pokemonListButton.applyShadow()
        pokemonListButton.configuration?.attributedTitle?.font = UIFont(name: Constants.customFontBold, size: 19)
        pokemonListButton.startAnimatingPressActions()
        
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
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func showPokemonTapped(_ sender: UIButton) {
        
    }
}

extension TypeDetailsViewController: TypeDetailsViewModelDelegate {
    func onDetailsModelFetchSuccess() {
        DispatchQueue.main.async {
            guard let details = self.viewModel.detailsModel else {
                return
            }
            
            self.typeNameLabel.text = details.name.uppercased()
            self.typeImageView.image = UIImage(named: details.name)
            self.pokemonListButton.setTitle("Show \(details.name) type Pokémon", for: .normal)

        }
    }
    
    func onDetailsModelFetchFailure(error: Error) {
        
    }
}
