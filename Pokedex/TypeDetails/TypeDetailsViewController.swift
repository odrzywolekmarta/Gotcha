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
    
    @IBOutlet weak var doubleHeight: NSLayoutConstraint!
    @IBOutlet weak var halfHeight: NSLayoutConstraint!
    @IBOutlet weak var zeroHeight: NSLayoutConstraint!

    @IBOutlet weak var doubleLabel: UILabel!
    @IBOutlet weak var halfLabel: UILabel!
    @IBOutlet weak var zeroLabel: UILabel!
    
    let viewModel: TypeDetailsViewModelProtocol
    let router: AppRouterProtocol
    var selectedSegment: SelectedSegment = .offensive
    var tables: [UITableView] = []
    
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
        viewModel.getTypeDetails()
        configureView()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        doubleHeight?.constant = doubleTableView.intrinsicContentSize.height
        halfHeight?.constant = halfTableView.intrinsicContentSize.height
        zeroHeight?.constant = zeroTableView.intrinsicContentSize.height
    }
    
    func configureView() {
        roundedView.makeRound(radius: 30)
        
        typeNameLabel.textDropShadow()
        typeImageView.applyShadow()
        
        backButton.applyShadow()
        backButton.configuration?.attributedTitle?.font = UIFont(name: Constants.customFontBold, size: 19)
        backButton.startAnimatingPressActions()
        
        pokemonListButton.applyShadow()
        pokemonListButton.startAnimatingPressActions()
        
        if let font = UIFont(name: Constants.customFont, size: 20) {
            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        }
        
        doubleLabel.applyShadow()
        halfLabel.applyShadow()
        zeroLabel.applyShadow()
        
        let cellName = String(describing: TypeTableViewCell.self)
                           
        tables = [doubleTableView, halfTableView, zeroTableView]
        for table in tables {
            table.delegate = self
            table.dataSource = self
            table.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
            table.separatorStyle = .none
            table.allowsSelection = false
            table.isScrollEnabled = false
        }
    }
    
    func reloadTables() {
        for table in tables {
            table.reloadData()
        }
    }
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedSegment = .offensive
            doubleLabel.backgroundColor = UIColor(named: "BugType")
            halfLabel.backgroundColor = UIColor(named: Constants.Colors.customRed)
            reloadTables()
        case 1:
            selectedSegment = .defensive
            doubleLabel.backgroundColor = UIColor(named: Constants.Colors.customRed)
            halfLabel.backgroundColor = UIColor(named: "BugType")
            reloadTables()
        default:
            ()
        }
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func showPokemonTapped(_ sender: UIButton) {
        // TODO: navigate to pokemon list
    }
}

extension TypeDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedSegment {
        case .offensive:
            switch tableView {
            case doubleTableView:
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
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
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
            if let font = UIFont(name: Constants.customFontBold, size: 19) {
                let title = NSMutableAttributedString(string: "Show \(details.name) type Pokémon", attributes: [NSAttributedString.Key.font: font])
                self.pokemonListButton.setAttributedTitle(title, for: .normal)
            }
         
            self.reloadTables()
        }
    }
    
    func onDetailsModelFetchFailure(error: Error) {
        print(error)
    }
}
