//
//  TypesViewController.swift
//  Gotcha
//
//  Created by Majka on 30/03/2023.
//

import UIKit

class TypesViewController: UIViewController {
    
    var segmentedControl: UISegmentedControl
    let viewModel: TypesViewModelProtocol
    var collectionView: UICollectionView?
    let router: AppRouterProtocol
    var types: [Results] = []
    private var previousController: UIViewController?
    
    init(viewModel: TypesViewModelProtocol, router: AppRouterProtocol) {
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureSegmentedControl()
    }
    
    func configureCollectionView() {
        view.backgroundColor = UIColor(named: Constants.Colors.customBeige)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let nibCell = UINib(nibName: "TypeCollectionViewCell", bundle: nil)
        let frame = CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height - 50)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.register(nibCell, forCellWithReuseIdentifier: Constants.typeCell)
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
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
      {
          print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
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
