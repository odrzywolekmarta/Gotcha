//
//  TypesViewController.swift
//  Gotcha
//
//  Created by Majka on 30/03/2023.
//

import UIKit

class TypesViewController: UIViewController {
    
    let viewModel: TypesViewModelProtocol
    var collectionView: UICollectionView?
    let router: AppRouterProtocol
    
    init(viewModel: TypesViewModelProtocol, router: AppRouterProtocol) {
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
        configureCollectionView()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        viewModel.getPokemonTypes()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.update(backroundColor: UIColor(named: Constants.Colors.customRed))
        tabBarController?.delegate = self
    }
    
    func configureCollectionView() {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
       
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
         collectionView?.register(TypeCollectionViewCell.self, forCellWithReuseIdentifier: Constants.typeCell)
         
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
//        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        collectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView?.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        
        view.addSubview(collectionView ?? UICollectionView())
    }

}

extension TypesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.typeCell, for: indexPath) as? TypeCollectionViewCell {
            cell.configure(name: viewModel.dataSource[indexPath.row].name)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension TypesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                    layout collectionViewLayout: UICollectionViewLayout,
                    sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: 100, height: 100)
     }
}

extension TypesViewController: TypesViewModelDelegate {
    func onTypesFetchSuccess() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func onTypesFetchFailure(error: String) {
        print(error)
    }
    
}

extension TypesViewController: UITabBarControllerDelegate {
    
}
