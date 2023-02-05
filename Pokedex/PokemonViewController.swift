//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Majka on 30/10/2022.
//

import UIKit

class PokemonViewController: UIViewController {
    
    let viewModel: PokemonListViewModelProtocol
    var tableView: UITableView
    let paginationOffset = 4
    let router: AppRouterProtocol
    var previousController: UIViewController?
    
    init(viewModel: PokemonListViewModelProtocol, router: AppRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        self.tableView = UITableView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        configureTableView()
        viewModel.getNextPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.update(backroundColor: UIColor(named: Constants.Colors.customRed))
        tabBarController?.delegate = self
    }
    
}

//MARK: - Table View Data Source

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell") as? PokemonTableViewCell {
            cell.configure(name: viewModel.dataSource[indexPath.row].name,
                           imageUrlString: viewModel.getPokemonImageUrl(forRow: indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == viewModel.dataSource.count - paginationOffset else {
            return
        }
        viewModel.getNextPage()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: move router to view model
        router.navigateToDetails(urlString: viewModel.dataSource[indexPath.row].url, imageUrl: viewModel.getPokemonImageUrl(forRow: indexPath.row))
    }
    
}

//MARK: - View Model Delegate

extension PokemonViewController: PokemonListViewModelDelegate {
    func onGetPageSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func onGetPageFailure(error: String) {
        // TODO: handle error. Perhaps make an option to retry?
        
        print(error)
    }
}

//MARK: - Tab Bar Controller Delegate

extension PokemonViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if self.previousController == viewController || self.previousController == nil {
            if let nav = viewController as? UINavigationController {
                if nav.viewControllers.count < 2 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        }
        self.previousController = viewController;
        return true
    }
    
}

