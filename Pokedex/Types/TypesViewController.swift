//
//  TypesViewController.swift
//  Gotcha
//
//  Created by Majka on 30/03/2023.
//

import UIKit

class TypesViewController: UIViewController {
    
    let viewModel: TypesViewModelProtocol
    var collectionView: UICollectionView
    let router: AppRouterProtocol
    
    init(viewModel: TypesViewModelProtocol, router: AppRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        self.collectionView = UICollectionView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        configureCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.update(backroundColor: UIColor(named: Constants.Colors.customRed))
        tabBarController?.delegate = self
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
    }

}

extension TypesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

extension TypesViewController: TypesViewModelDelegate {
    func onTypesFetchSuccess() {
        
    }
    
    func onTypesFetchFailure(error: String) {
        
    }
    
}

extension TypesViewController: UITabBarControllerDelegate {
    
}
