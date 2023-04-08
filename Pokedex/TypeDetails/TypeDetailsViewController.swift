//
//  TypeDetailsViewController.swift
//  Gotcha
//
//  Created by Majka on 07/04/2023.
//

import UIKit

class TypeDetailsViewController: UIViewController {
    
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
    lazy var blurredView: UIView = {
            let containerView = UIView()
            let blurEffect = UIBlurEffect(style: .light)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
            customBlurEffectView.frame = self.view.bounds
            let dimmedView = UIView()
            dimmedView.backgroundColor = .black.withAlphaComponent(0.6)
            dimmedView.frame = self.view.bounds
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
        }()
    
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
        
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
        
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
        
        configureCollectionViews()
    }
    
    func configureCollectionViews() {
        collections = [doubleToCollectionView, halfToCollectionView, zeroToCollectionView, halfFromCollectionView, doubleFromCollectionView, zeroFromCollectionView]
        
        for collection in collections {
            let layout = UICollectionViewLayout()
            collection.setCollectionViewLayout(layout, animated: true)
            let nibCell = UINib(nibName: "TypeCollectionViewCell", bundle: nil)
            collection.register(nibCell, forCellWithReuseIdentifier: Constants.capsuleCell)
            collection.backgroundColor = .systemGray
            collection.backgroundView?.makeRound()
        }
        
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
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
        return UICollectionViewCell()
    }
    
    
}

extension TypeDetailsViewController: TypeDetailsViewModelDelegate {
    func onDetailsModelFetchSuccess() {
        
    }
    
    func onDetailsModelFetchFailure(error: Error) {
        
    }
}
