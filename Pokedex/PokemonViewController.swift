//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Majka on 30/10/2022.
//

import UIKit

enum OpenedFrom {
    case listTab
    case type
}

class PokemonViewController: UIViewController {
    
    let viewModel: PokemonListViewModelProtocol
    private var tableView: UITableView
    private let paginationOffset = 4
    let router: AppRouterProtocol
    private var previousController: UIViewController?
    private var openedFrom: OpenedFrom
    private var spinner: UIActivityIndicatorView?
    private var failView: FailViewController?

    
    init(viewModel: PokemonListViewModelProtocol, router: AppRouterProtocol, openedFrom: OpenedFrom) {
        self.viewModel = viewModel
        self.router = router
        self.openedFrom = openedFrom
        self.tableView = UITableView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        configureTableView()
        addSpinner()

        if openedFrom == .listTab {
            spinner?.startAnimating()
            viewModel.getNextPage()
        }
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
    }
    
    func addSpinner() {
        spinner = UIActivityIndicatorView(style: .large)
        view.configureSpinner(spinner: spinner ?? UIActivityIndicatorView(), backgroundColor: UIColor(named: Constants.Colors.customBeige) ?? .gray, indicatorColor: UIColor(named: Constants.Colors.customRed) ?? .white)
    }
    
    func addFailView() {
        failView = FailViewController()
        failView?.delegate = self
        if let fail = failView {
            addChild(fail)
            self.view.addSubview(fail.view)
        }
        failView?.didMove(toParent: self)
        failView?.view.frame = view.bounds
        failView?.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func removeFailView() {
        if let fail = failView {
            fail.removeFromParent()
        }
    }
}

//MARK: - Table View Data Source

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch openedFrom {
        case .listTab:
            return viewModel.dataSource.count
        case .type:
            return viewModel.typePokemon.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.pokemonCell) as? PokemonTableViewCell {
            switch openedFrom {
            case .listTab:
                cell.configure(name: viewModel.dataSource[indexPath.row].name,
                               imageUrlString: viewModel.getPokemonImageUrl(forRow: indexPath.row, openedFrom: openedFrom))
                return cell
            case .type:
                cell.configure(name: viewModel.typePokemon[indexPath.row].pokemon.name, imageUrlString: viewModel.getPokemonImageUrl(forRow: indexPath.row, openedFrom: openedFrom))
                return cell
            }
            
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
        switch openedFrom {
        case .listTab:
            router.navigateToDetails(urlString: viewModel.dataSource[indexPath.row].url, imageUrl: viewModel.getPokemonImageUrl(forRow: indexPath.row, openedFrom: openedFrom))
        case .type:
            router.navigateToDetails(urlString: viewModel.typePokemon[indexPath.row].pokemon.url, imageUrl: viewModel.getPokemonImageUrl(forRow: indexPath.row, openedFrom: openedFrom))
        }
       
    }
    
}

//MARK: - View Model Delegate

extension PokemonViewController: PokemonListViewModelDelegate {
    func onGetPageSuccess() {
        DispatchQueue.main.async {
            self.spinner?.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func onGetPageFailure(error: String) {
        DispatchQueue.main.async {
            self.spinner?.stopAnimating()
            self.addFailView()
            debugPrint(error)
        }
    }
    
}

//MARK: - Tab Bar Controller Delegate

extension PokemonViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if self.previousController == viewController || self.previousController == nil {
            if let nav = viewController as? UINavigationController {
                if nav.viewControllers.count < 3 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
        }
        self.previousController = viewController;
        return true
    }
    
}

//MARK: - Fail View Delegate

extension PokemonViewController: FailViewControllerDelegate {
    func handleFail() {
        spinner?.startAnimating()
        viewModel.getNextPage()
    }
    
}

