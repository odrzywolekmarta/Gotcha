//
//  TypeDetailsViewController.swift
//  Gotcha
//
//  Created by Majka on 07/04/2023.
//

import UIKit

enum SelectedSegment {
    case offensive
    case defensive
}

enum TableType {
    case doubleFrom
    case halfFrom
    case zeroFrom
    case doubleTo
    case halfTo
    case zeroTo
}

class TypeDetailsViewController: UIViewController {
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var pokemonListButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var doubleTableView: UITableView!
    @IBOutlet weak var zeroTableView: UITableView!
    @IBOutlet weak var halfTableView: UITableView!
    
    let viewModel: TypeDetailsViewModelProtocol
    let router: AppRouterProtocol
    var selectedSegment: SelectedSegment = .offensive
    var tables: [UITableView] = []
//    var pageViewController: TypePageViewController?
    
    init(viewModel: TypeDetailsViewModelProtocol, router: AppRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
//        self.pageViewController = TypePageViewController(appRouter: router)
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
        
        if let font = UIFont(name: Constants.customFont, size: 20) {
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        }
        
        let cellName = String(describing: TypeTableViewCell.self)
                           
        tables = [doubleTableView, halfTableView, zeroTableView]
        for table in tables {
            table.delegate = self
            table.dataSource = self
            table.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
            table.separatorStyle = .none
            table.allowsSelection = false
        }
    }
    
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedSegment = .offensive
        case 1:
            selectedSegment = .defensive
        default:
            ()
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
        guard let details = self.viewModel.detailsModel else {
            return
        }
                
        DispatchQueue.main.async {
            self.typeNameLabel.text = details.name.uppercased()
            self.typeImageView.image = UIImage(named: details.name)
            self.pokemonListButton.setTitle("Show \(details.name) type Pokémon", for: .normal)
            for table in self.tables {
                table.reloadData()
            }
        }
    }
    
    func onDetailsModelFetchFailure(error: Error) {
        print(error)
    }
}

extension TypeDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedSegment {
        case .offensive:
            switch tableView {
            case doubleTableView:
                let count = viewModel.detailsModel?.damageRelations.doubleDamageTo.count ?? 0
                return viewModel.detailsModel?.damageRelations.doubleDamageTo.count ?? 0
            case halfTableView:
                return viewModel.detailsModel?.damageRelations.halfDamageTo.count ?? 0
            case zeroTableView:
                return viewModel.detailsModel?.damageRelations.noDamageTo.count ?? 0
            default:
                ()
            }
        case .defensive:
            switch tableView {
            case doubleTableView:
                return viewModel.detailsModel?.damageRelations.doubleDamageFrom.count ?? 0
            case halfTableView:
                return viewModel.detailsModel?.damageRelations.halfDamageFrom.count ?? 0
            case zeroTableView:
                return viewModel.detailsModel?.damageRelations.noDamageFrom.count ?? 0
            default:
                ()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTableViewCell") as? TypeTableViewCell,
           let data = viewModel.detailsModel?.damageRelations {
            switch selectedSegment {
            case .offensive:
                switch tableView {
                case doubleTableView:
                    cell.configure(name: data.doubleDamageTo[indexPath.row].name)
                    return cell
                case halfTableView:
                    cell.configure(name: data.halfDamageTo[indexPath.row].name)
                    return cell
                case zeroTableView:
                    cell.configure(name: data.noDamageTo[indexPath.row].name)
                    return cell
                default:
                    return UITableViewCell()
                }
            case .defensive:
                switch tableView {
                case doubleTableView:
                    cell.configure(name: data.doubleDamageFrom[indexPath.row].name)
                    return cell
                case halfTableView:
                    cell.configure(name: data.halfDamageFrom[indexPath.row].name)
                    return cell
                case zeroTableView:
                    cell.configure(name: data.noDamageFrom[indexPath.row].name)
                    return cell
                default:
                    return UITableViewCell()
                }
            default:
                ()
            }
        }
        return UITableViewCell()
    }
    
    
}
