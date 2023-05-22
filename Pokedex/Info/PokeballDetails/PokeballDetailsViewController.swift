//
//  PokeballDetailsViewController.swift
//  Gotcha
//
//  Created by Majka on 08/05/2023.
//

import UIKit

class PokeballDetailsViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ballImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var descriptionContainerView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    let viewModel: PokeballDetailsViewModelProtocol
    let router: AppRouterProtocol
    
    init(router: AppRouterProtocol, viewModel: PokeballDetailsViewModelProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView(_:)))
        backgroundView.addGestureRecognizer(tap)
    }
    
    func configure() {
        view.addBluredBackground()
        let pokeballName = viewModel.detailsModel.name.removeDash()
        nameLabel.text = pokeballName.uppercased()
        nameLabel.textDropShadow()
        
        costLabel.text = "cost: \(String(viewModel.detailsModel.cost))"
        
        containerView.makeRound(radius: 30)
        
        if let imageUrl = URL(string: "\(Constants.basePokeballImageUrl)\(viewModel.detailsModel.name).png") {
            ballImage.sd_setImage(with: imageUrl)
        }
        ballImage.applyShadow()
        
        descriptionLabel.text = viewModel.detailsModel.effectEntries[0].shortEffect
        descriptionContainerView.makeRound(radius: 30)
        descriptionContainerView.applyShadow()
    }
    
    @objc func dismissView(_ sender: UIView) {
        self.dismiss(animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
