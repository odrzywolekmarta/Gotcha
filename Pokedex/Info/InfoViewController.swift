//
//  TypesViewController.swift
//  Gotcha
//
//  Created by Majka on 30/03/2023.
//

import UIKit

enum InfoDisplayed {
    case types
    case pokeballs
}

class InfoViewController: UIViewController {
    
    private var segmentedControl: UISegmentedControl
    private let viewModel: InfoViewModelProtocol
    private var collectionView: UICollectionView?
    private let router: AppRouterProtocol
    private var types: [Results] = []
    private var previousController: UIViewController?
    private var info: InfoDisplayed = .types
    
    init(viewModel: InfoViewModelProtocol, router: AppRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        self.segmentedControl = UISegmentedControl()
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
        viewModel.getPokeballList()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureSegmentedControl()
    }
    
    func configureCollectionView() {
        view.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let nibCell = UINib(nibName: Constants.infoCell, bundle: nil)
        let frame = CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height - 50)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.register(nibCell, forCellWithReuseIdentifier: Constants.infoCell)
        collectionView?.layoutIfNeeded()
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        
        view.addSubview(collectionView ?? UICollectionView())
    }
    
    func configureSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["TYPES", "POKEBALLS"])
        segmentedControl.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: 50)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        if let font = UIFont(name: Constants.customFontBold, size: 17) {
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        }
        view.addSubview(segmentedControl)
        
        // update collection view frame
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 50, width: view.frame.width, height: view.frame.height - 50 - view.safeAreaInsets.top)
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
        case 0:
            info = .types
            collectionView?.reloadData()
        case 1:
            info = .pokeballs
            collectionView?.reloadData()
        default:
            ()
        }
    }
    
}

extension InfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch info {
        case .types:
            return types.count
        case .pokeballs:
            return viewModel.pokeballs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.infoCell, for: indexPath) as? InfoCollectionViewCell {
            switch info {
            case .types:
                cell.configureWithType(name: types[indexPath.row].name)
                return cell
            case .pokeballs:
                cell.configureWithPokeball(name: viewModel.pokeballs[indexPath.row].name)
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch info {
        case .types:
            viewModel.getTypeDetails(forId: indexPath.item + 1)
        case .pokeballs:
            viewModel.getPokeballDetails(forName: viewModel.pokeballs[indexPath.item].name)
        }
    }
}

extension InfoViewController: UICollectionViewDelegateFlowLayout {
    
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

extension InfoViewController: InfoViewModelDelegate {

    func onTypeDetailsModelFetchSuccess() {
        DispatchQueue.main.async {
            if let model = self.viewModel.typeDetails {
                self.router.navigateToType(withModel: model)
            }
        }
    }
    
    func onTypeDetailsModelFetchFailure(error: Error) {
        // handle error
    }
    
    func onPokeballFetchSuccess() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func onPokeballFetchFailure(error: Error) {
        DispatchQueue.main.async {
            debugPrint(error)
        }
    }
    
    func onTypesFetchSuccess() {
        DispatchQueue.main.async {
            self.types = self.viewModel.types.filter { $0.name != "shadow" && $0.name != "unknown" }
            self.collectionView?.reloadData()
        }
    }
    
    func onTypesFetchFailure(error: Error) {
        DispatchQueue.main.async {
            debugPrint(error)
        }
    }
    
    func onPokeballDetailsFetchSuccess() {
        DispatchQueue.main.async {
            if let model = self.viewModel.pokeballDetails {
                self.router.navigateToPokeball(withModel: model)
            }
        }
    }
    
    func onPokeballDetailsFetchFailure(error: Error) {
        
    }
    
    
    
}
