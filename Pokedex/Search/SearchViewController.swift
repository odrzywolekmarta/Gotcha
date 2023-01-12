//
//  SearchViewController.swift
//  Gotcha
//
//  Created by Majka on 08/12/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var randomButton: UIButton!
    
   
    let viewModel: SearchViewModelProtocol = SearchViewModel()
    let router: AppRouterProtocol
    
    init(router: AppRouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        searchTextField.delegate = self
        
        pokemonImage.sd_setImage(with: URL(string: Constants.pokemonGifUrl))
        pokemonImage.applyShadow()
        randomButton.configuration?.attributedTitle?.font = UIFont(name: Constants.customFontBold, size: 15)
        searchTextField.applyShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.update(backroundColor: UIColor(named: Constants.Colors.customBeige))
        randomButton.isUserInteractionEnabled = true
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    @IBAction func randomPressed(_ sender: UIButton) {
        let randomIdString = String(Int.random(in: 1...905))
        let randomPokemonUrl = Constants.basePokemonUrl + randomIdString
        viewModel.getPokemonDetails(withUrlString: randomPokemonUrl)
        randomButton.isUserInteractionEnabled = false
    }
    
    
}

//MARK: - Text Field Delegate

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }
    
    func toggleUIEnabled(enabled: Bool) {
        searchTextField.isUserInteractionEnabled = enabled
        searchButton.isUserInteractionEnabled = enabled
        randomButton.isUserInteractionEnabled = enabled
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let pokemonData = searchTextField.text {
            let pokemonUrl = Constants.basePokemonUrl + pokemonData
            viewModel.getPokemonDetails(withUrlString: pokemonUrl)
            searchTextField.text = ""
            toggleUIEnabled(enabled: false)
        } else {
            searchTextField.text = ""
        }
    }
    
}

//MARK: - Search View Model Delegate

extension SearchViewController: SearchViewModelDelegate {
    func onDetailsModelFetchSuccess() {
        DispatchQueue.main.async {
            self.toggleUIEnabled(enabled: true)
            if let model = self.viewModel.detailsModel {
                self.router.navigateToDetails(withModel: model)
            }
        }
    }
    
    func onDetailsModelFetchFailure(error: Error) {
        DispatchQueue.main.async {
            self.toggleUIEnabled(enabled: true)
            self.presentAlert(with: error)
        }
    }
    
}
