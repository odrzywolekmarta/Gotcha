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
    
    @IBOutlet weak var doubleToCollectionView: UICollectionView!
    @IBOutlet weak var halfToCollectionView: UICollectionView!
    @IBOutlet weak var zeroToCollectionView: UICollectionView!
    @IBOutlet weak var halfFromCollectionView: UICollectionView!
    @IBOutlet weak var doubleFromCollectionView: UICollectionView!
    @IBOutlet weak var zeroFromCollectionView: UICollectionView!
    
    @IBOutlet weak var pokemonListButton: UIButton!
    
    let viewModel: TypeDetailsViewModelProtocol
    let router: AppRouterProtocol
    var collections: [UICollectionView] = []
    
    init(viewModel: TypeDetailsViewModelProtocol, router: AppRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        doubleToCollectionView.delegate = self
        doubleToCollectionView.dataSource = self
        halfToCollectionView.delegate = self
        halfToCollectionView.dataSource = self
        zeroToCollectionView.delegate = self
        zeroToCollectionView.dataSource = self
        halfFromCollectionView.delegate = self
        halfFromCollectionView.dataSource = self
        doubleFromCollectionView.delegate = self
        doubleToCollectionView.dataSource = self
        zeroFromCollectionView.delegate = self
        zeroFromCollectionView.dataSource = self
        
        viewModel.getTypeDetails()
        configureView()
        configureCollectionViews()
    }
    
    func configureCollectionViews() {
        collections = [doubleToCollectionView, halfToCollectionView, zeroToCollectionView, halfFromCollectionView, doubleFromCollectionView, zeroFromCollectionView]
        
        for collection in collections {
            var config = UICollectionLayoutListConfiguration(appearance: .plain)
            config.backgroundColor = .clear
            config.showsSeparators = false
            collection.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
            let nibCell = UINib(nibName: Constants.capsuleCell, bundle: nil)
            collection.register(nibCell, forCellWithReuseIdentifier: Constants.capsuleCell)
        }
        
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
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func showPokemonTapped(_ sender: UIButton) {
        
    }
}

extension TypeDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let relations = viewModel.detailsModel?.damageRelations {
            switch collectionView {
            case doubleToCollectionView:
                return relations.doubleDamageTo.count
            case halfToCollectionView:
                return relations.halfDamageTo.count
            case zeroToCollectionView:
                return relations.noDamageTo.count
            case doubleFromCollectionView:
                return relations.doubleDamageFrom.count
            case halfFromCollectionView:
                return relations.halfDamageFrom.count
            case zeroFromCollectionView:
                return relations.noDamageFrom.count
            default:
                return 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let relations = viewModel.detailsModel?.damageRelations else {
            return UICollectionViewCell()
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.capsuleCell, for: indexPath) as? TypeCapsuleCollectionViewCell {
            switch collectionView {
            case doubleToCollectionView:
                cell.configure(name: relations.noDamageFrom[indexPath.row].name)
                return cell
            case halfToCollectionView:
                cell.configure(name: relations.halfDamageFrom[indexPath.row].name)
                return cell
            case zeroToCollectionView:
                cell.configure(name: relations.noDamageTo[indexPath.row].name)
                return cell
            case doubleFromCollectionView:
                cell.configure(name: relations.doubleDamageFrom[indexPath.row].name)
                return cell
            case halfFromCollectionView:
                cell.configure(name: relations.halfDamageFrom[indexPath.row].name)
                return cell
            case zeroFromCollectionView:
                cell.configure(name: relations.noDamageFrom[indexPath.row].name)
            default:
                return UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
    }
}

extension TypeDetailsViewController: TypeDetailsViewModelDelegate {
    func onDetailsModelFetchSuccess() {
        DispatchQueue.main.async {
            if let type = self.viewModel.detailsModel?.name {
                self.typeNameLabel.text = type.uppercased()
                self.typeImageView.image = UIImage(named: type)
                self.pokemonListButton.setTitle("Show \(type) type Pokémon", for: .normal)
            }
            self.doubleFromCollectionView.reloadData()
            self.halfFromCollectionView.reloadData()
            self.zeroFromCollectionView.reloadData()
            self.doubleToCollectionView.reloadData()
            self.halfToCollectionView.reloadData()
            self.zeroToCollectionView.reloadData()
        }
    }
    
    func onDetailsModelFetchFailure(error: Error) {
        
    }
}
