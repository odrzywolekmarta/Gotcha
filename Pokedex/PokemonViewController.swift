//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Majka on 30/10/2022.
//

import UIKit

class PokemonViewController: UIViewController {
    
    let viewModel: PokemonViewModelProtocol
    var tableView: UITableView
    let paginationOffset = 4
    
    init(viewModel: PokemonViewModelProtocol) {
        self.viewModel = viewModel
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        configureTableView()
        viewModel.getNextPage()
    }

}

//MARK: - Table View Data Source

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell") as? PokemonTableViewCell {
            var configuration = cell.defaultContentConfiguration()
            configuration.text = viewModel.dataSource[indexPath.row].name
            cell.contentConfiguration = configuration
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
        let viewController = UIViewController()
        viewController.view.backgroundColor = .cyan
        present(viewController, animated: true)
    }
}

//MARK: - View Model Delegate

extension PokemonViewController: PokemonViewModelDelegate {
    func onGetPageSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func onGetPageFailure(error: String) {
        print(error)
    }
}

