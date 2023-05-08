//
//  PokeballDetailsViewController.swift
//  Gotcha
//
//  Created by Majka on 08/05/2023.
//

import UIKit

class PokeballDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ballImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
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
        // Do any additional setup after loading the view.
    }
    
    func configure() {
        nameLabel.text = viewModel.detailsModel.name
        costLabel.text = "cost: \(String(viewModel.detailsModel.cost))"
//        descriptionLabel.text = viewModel.detailsModel.effectEntries[0].shortEffect
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
