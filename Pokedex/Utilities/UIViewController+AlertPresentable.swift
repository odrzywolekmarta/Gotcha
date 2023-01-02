//
//  UIViewController+AlertPresentable.swift
//  Gotcha
//
//  Created by Majka on 11/12/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(with error: Error) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.customFont, size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleString = NSAttributedString(string: "OOPS!", attributes: titleAttributes)
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.customFont, size: 18)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        let messageString = NSAttributedString(string: "SOMETHING WENT WRONG", attributes: messageAttributes)

        alertController.setValue(titleString, forKey: "attributedTitle")
        alertController.setValue(messageString, forKey: "attributedMessage")

            self.present(alertController, animated: true, completion: nil)
    }

    func presentAlert(description: String) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
     
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.customFont, size: 18)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        let messageString = NSAttributedString(string: description, attributes: messageAttributes)

        alertController.setValue(messageString, forKey: "attributedMessage")

            self.present(alertController, animated: true, completion: nil)
    }
}
