//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Majka on 30/10/2022.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokeArray = ["pikachu", "snorlax", "charmander", "jigglypuff", "bulbasaur"]
    let service = PokemonAPIService()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.getPokemonList { result in
            
        }
        tableView.delegate = self
        tableView.dataSource = self
    }

}
//MARK: - Table view data source

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return pokeArray.count
        return service.pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
//        cell.textLabel?.text = pokeArray[indexPath.row]
        cell.textLabel?.text = service.pokemonArray[indexPath.row].name
        return cell
    }
    
    
}
