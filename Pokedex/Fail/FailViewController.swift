//
//  FailViewController.swift
//  Gotcha
//
//  Created by Majka on 18/05/2023.
//

import UIKit

protocol FailViewControllerDelegate: AnyObject {
    func handleFail()
}

class FailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var retryButton: UIButton!
    
    weak var delegate: FailViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func configure() {
        if let path = Bundle.main.path(forResource: Constants.failGif, ofType: Constants.gifType) {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
            let image = UIImage.sd_image(withGIFData: data)
            imageView.image = image
        }
        imageView.applyShadow()
        retryButton.titleLabel?.font = Constants.abilityButtonFont
        retryButton.backgroundColor = .black.withAlphaComponent(0.1)
        retryButton.makeRound(radius: 15)
        retryButton.applyShadow()
        retryButton.startAnimatingPressActions()
    }
    
    @IBAction func refreshTapped(_ sender: UIButton) {
        delegate?.handleFail()
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
}
