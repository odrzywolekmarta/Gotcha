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

    }



}
