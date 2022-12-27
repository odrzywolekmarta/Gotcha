//
//  FavouritesViewController.swift
//  Gotcha
//
//  Created by Majka on 07/12/2022.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    var tableView: UITableView
    var favourites = Favourites()
    let baseUrlString = "https://pokeapi.co/api/v2/pokemon/"
    let baseImageUrlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    let router: AppRouterProtocol
    
    init(router: AppRouterProtocol) {
        self.router = router
        self.tableView = UITableView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favourites.fetch()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.update(backroundColor: UIColor(named: Constants.Colors.customRed))
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        let cellName = String(describing: PokemonTableViewCell.self)
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: Constants.Colors.customBeige)
    }

}

//MARK: - Table View Methods

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favourites.favouritesArray.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell") as? PokemonTableViewCell {
            
            let idString = String(favourites.favouritesArray[indexPath.row].id)
            let urlString = "\(baseImageUrlString)\(idString).png"
            cell.configure(name: favourites.favouritesArray[indexPath.row].name, imageUrlString: urlString)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idString = String(favourites.favouritesArray[indexPath.row].id)
        let url = "\(baseUrlString)\(idString)"
        router.navigateToDetails(urlString: url)
    }
    
}
