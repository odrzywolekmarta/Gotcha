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
    @IBOutlet weak var randomLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
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
        
        pokemonImage.sd_setImage(with: URL(string: "https://78.media.tumblr.com/c15b061360fa577cfa6fa1868bc45962/tumblr_o2d65b8VYl1so9b4uo1_500.gif"))
        pokemonImage.applyShadow()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
}

//MARK: - Text Field Delegate

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
    
}
