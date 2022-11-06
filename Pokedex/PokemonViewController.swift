//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Majka on 30/10/2022.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokeArray = ["pikachu", "snorlax", "charmander", "jigglypuff", "bulbasaur"]
    let viewModel: PokemonViewModelProtocol
    
    
    init(viewModel: PokemonViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.getNextPage()
    }

}
//MARK: - Table View Data Source

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = viewModel.dataSource[indexPath.row].name
        cell.contentConfiguration = configuration
        return cell
    }
    
    
}

//MARK: - View Model Delegate

extension PokemonViewController: PokemonViewModelDelegate {
    func onGetPageSuccess() {
        tableView.reloadData()
    }
    
    func onGetPageFailure(error: String) {
        print(error)
    }
}

