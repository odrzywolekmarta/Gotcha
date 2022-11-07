//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Majka on 06/11/2022.
//

import UIKit

class PokemonDetailsViewController: UIViewController, PokemonListViewModelDelegate {
    
    func onGetPageSuccess() {
        sleep(3)
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        }
    }
    
    func onGetPageFailure(error: String) {
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        }
    }
    
    
    var tableView = UITableView()
    let viewModel = PokemonDetailsViewModel()
    
    func configureTableView() {
        view.addSubview(tableView)
        let cellName = String(describing: AbilitiesTableViewCell.self)
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
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
        viewModel.getPokemonDetails(withUrlString: "https://pokeapi.co/api/v2/pokemon/1/")
    }
    
}


//MARK: - Table View Data Source

extension PokemonDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AbilitiesTableViewCell") as? AbilitiesTableViewCell {
            return cell
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
