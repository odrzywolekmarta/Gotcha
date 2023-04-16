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
    var types: [Results] = []
    private var previousController: UIViewController?
    
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
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let nibCell = UINib(nibName: "TypeCollectionViewCell", bundle: nil)
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView?.register(nibCell, forCellWithReuseIdentifier: Constants.typeCell)
        collectionView?.layoutIfNeeded()
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        
        view.addSubview(collectionView ?? UICollectionView())
    }
}

extension TypesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.typeCell, for: indexPath) as? TypeCollectionViewCell {
            cell.configure(name: types[indexPath.row].name)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string: viewModel.dataSource[indexPath.row].url) {
            router.navigateToType(url: url)
        }
    }
}

extension TypesViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: 0, height: 0)
        }
        let numberOfCellsInRow = 3
        let totalSpace = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing * CGFloat(numberOfCellsInRow - 1)
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}

extension TypesViewController: TypesViewModelDelegate {
    func onTypesFetchSuccess() {
        DispatchQueue.main.async {
            self.types = self.viewModel.dataSource.filter { $0.name != "shadow" && $0.name != "unknown" }
            self.collectionView?.reloadData()
        }
    }
    
    func onTypesFetchFailure(error: String) {
        print(error)
    }
    
}
