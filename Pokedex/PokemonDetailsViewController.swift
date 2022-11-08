//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Majka on 06/11/2022.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
  
    
    var tableView = UITableView()
    let viewModel: PokemonDetailsViewModelProtocol
    let router: AppRouterProtocol
    
    init(viewModel: PokemonDetailsViewModelProtocol, router: AppRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func configureTableView() {
        view.addSubview(tableView)
        
        let pictureCellName = String(describing: PictureTableViewCell.self)
        tableView.register(UINib(nibName: pictureCellName, bundle: nil), forCellReuseIdentifier: pictureCellName)
        let nameCellName = String(describing: NameTableViewCell.self)
        tableView.register(UINib(nibName: nameCellName, bundle: nil), forCellReuseIdentifier: nameCellName)
        let typesCellName = String(describing: TypesTableViewCell.self)
        tableView.register(UINib(nibName: typesCellName, bundle: nil), forCellReuseIdentifier: typesCellName)
        let abilitiesCellName = String(describing: AbilitiesTableViewCell.self)
        tableView.register(UINib(nibName: abilitiesCellName, bundle: nil), forCellReuseIdentifier: abilitiesCellName)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        configureTableView()
        viewModel.getPokemonDetails()
    }
    
}


//MARK: - Table View Data Source

extension PokemonDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PictureTableViewCell") as? PictureTableViewCell {
                cell.configure(imageUrlString: viewModel.imageUrl)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as? NameTableViewCell {
                cell.configure(name: viewModel.detailsModel?.name ?? "")
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TypesTableViewCell") as? TypesTableViewCell {
                cell.configure(with: viewModel.detailsModel)
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AbilitiesTableViewCell") as? AbilitiesTableViewCell {
                cell.configure(with: viewModel.detailsModel)
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.detailsModel == nil {
            return 0
        } else {
            return 60
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.detailsModel == nil {
            return 0
        } else {
            return 60
            return UITableView.automaticDimension
        }
    }
    
}

//MARK: - View Model Delegate

extension PokemonDetailsViewController: PokemonDetailsViewModelDelegate {
    func onDetailsModelFetchSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func onDetailsModelFetchFailure(error: String) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print(error)
    }
}
