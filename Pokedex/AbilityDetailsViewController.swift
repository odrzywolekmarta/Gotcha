//
//  AbilityDetailsViewController.swift
//  Gotcha
//
//  Created by Majka on 18/05/2023.
//

import UIKit

class AbilityDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    let viewModel: AbilityDetailsViewModelProtocol
    let router: AppRouterProtocol
    
    init(router: AppRouterProtocol, viewModel: AbilityDetailsViewModelProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView(_:)))
        backgroundView.addGestureRecognizer(tap)
    }

    func configureView() {
        view.addBluredBackground()
        let abilityName = viewModel.detailsModel.name.removeDash()
        nameLabel.text = abilityName.uppercased()
        nameLabel.textDropShadow()
        contentView.makeRound(radius: 30)
        contentView.applyShadow()
        roundedView.makeRound(radius: 30)
        roundedView.applyShadow()
        
        let englishDescription = viewModel.detailsModel.effectEntries.filter { description in
                description.language.name == "en"
            }
            
            if englishDescription.count == 0 {
                descriptionLabel.text = Constants.noAbilityDescription
            } else {
                if englishDescription[0].effect.count > 700 {
                    descriptionLabel.text = englishDescription[0].shortEffect.removeNewLines()
                } else {
                    descriptionLabel.text = englishDescription[0].effect
                }
            }

        setFontSize()
    }
    
    func setFontSize() {
        if descriptionLabel.text?.count ?? 0 > 500 {
            descriptionLabel.font = UIFont(name: Constants.customFont, size: 16)
        }
    }
    
    @objc func dismissView(_ sender: UIView) {
        self.dismiss(animated: true)
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
}
