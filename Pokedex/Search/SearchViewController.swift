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
        searchTextField.delegate = self
        configureView()
    }
    
    func configureView() {
        if let path = Bundle.main.path(forResource: Constants.searchGif, ofType: Constants.gifType) {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
            let image = UIImage.sd_image(withGIFData: data)
            pokemonImage.image = image
        }
        pokemonImage.applyShadow()
        randomButton.configuration?.attributedTitle?.font = UIFont(name: Constants.customFontBold, size: 15)
        searchTextField.applyShadow()
        randomButton.startAnimatingPressActions()
        searchButton.startAnimatingPressActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.update(backroundColor: UIColor(named: Constants.Colors.customBeige))
        toggleUIEnabled(enabled: true)
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    @IBAction func randomPressed(_ sender: UIButton) {
        let randomIdString = String(Int.random(in: 1...905))
        let randomPokemonUrl = Constants.basePokemonUrl + randomIdString
        self.router.navigateToDetails(urlString: randomPokemonUrl)
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
            self.router.navigateToDetails(urlString: pokemonUrl)
            searchTextField.text = ""
            toggleUIEnabled(enabled: false)
        } else {
            searchTextField.text = ""
        }
    }
    
}
