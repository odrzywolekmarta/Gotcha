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
    private let baseUrlString = Constants.basePokemonUrl
    private let baseImageUrlString = Constants.baseImageUrl
    let router: AppRouterProtocol
    private var previousController: UIViewController?
    
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
        tabBarController?.delegate = self
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clear))
        
    }
    
    @objc func clear() {
        favourites.clear()
        tableView.reloadData()
    }
    
}

//MARK: - Table View Methods

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favourites.favouritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.pokemonCell) as? PokemonTableViewCell {
            
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.favourites.remove(self.favourites.favouritesArray[indexPath.row])
            self.favourites.fetch()
            tableView.reloadData()
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = UIColor(named: Constants.Colors.customRed)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

//MARK: - Tab Bar Controller Delegate
extension FavouritesViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if self.previousController == viewController || self.previousController == nil {
            let nav = viewController as! UINavigationController
            if nav.viewControllers.count < 3, tableView.numberOfRows(inSection: 0) > 0 {
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        self.previousController = viewController;
        return true
    }
    
}
