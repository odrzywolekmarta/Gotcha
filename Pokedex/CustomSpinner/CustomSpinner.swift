//
//  CustomSpinner.swift
//  Gotcha
//
//  Created by Majka on 16/04/2023.
//

import Foundation
import UIKit
import ImageIO

extension UIViewController {
    func toggleSpinner(active: Bool) {
        if active {
            let spinner = CustomSpinnerView(frame: view.bounds)
            spinner.imageView.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
            view.addSubview(spinner)
            view.bringSubviewToFront(spinner)
        } else {
            for subview in view.subviews {
                if subview.isKind(of: CustomSpinnerView.self) {
                    UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve) {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
}

class CustomSpinnerView: UIView {
    var imageView: UIImageView
    var background: UIView
    
    override init(frame: CGRect) {
        self.background = UIView(frame: .zero)
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 137))
        super.init(frame: frame)
        configure()
    }
            
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        if let path = Bundle.main.path(forResource: Constants.loadingGif, ofType: Constants.gifType) {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
            let image = UIImage.sd_image(withGIFData: data)
            imageView.image = image
        }

        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = UIColor(named: Constants.Colors.customOrange)
        background.frame = self.frame
        background.layoutIfNeeded()
        imageView.layoutIfNeeded()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit

        addSubview(background)
        addSubview(imageView)
        
    }

}

