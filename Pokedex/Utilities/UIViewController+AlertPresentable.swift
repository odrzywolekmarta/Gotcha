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
        let title = "OOPS!"
        let message = "SOMETHING WENT WRONG"
        let action = "OK"
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: action, style: .default))
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.customFont, size: 20) ?? .systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleString = NSAttributedString(string: title, attributes: titleAttributes)
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.customFont, size: 18) ?? .systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.black]
        let messageString = NSAttributedString(string: message, attributes: messageAttributes)
        
        alertController.setValue(titleString, forKey: "attributedTitle")
        alertController.setValue(messageString, forKey: "attributedMessage")
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlert() {
        let title = "OOPS!"
        let message = "SOMETHING WENT WRONG, WANNA TRY AGAIN?"
        let okAction = "OK"
        let retryAction = "RETRY"
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: okAction, style: .default))
        alertController.addAction(UIAlertAction(title: retryAction, style: .default) { _ in
            
        })
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.customFont, size: 20) ?? .systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleString = NSAttributedString(string: title, attributes: titleAttributes)
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.customFont, size: 18) ?? .systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.black]
        let messageString = NSAttributedString(string: message, attributes: messageAttributes)
        
        alertController.setValue(titleString, forKey: "attributedTitle")
        alertController.setValue(messageString, forKey: "attributedMessage")
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlert(title: String, description: String) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.customFontBold, size: 20) ?? .systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleString = NSAttributedString(string: title.uppercased(), attributes: titleAttributes)
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.customFont, size: 18) ?? .systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black]
        let messageString = NSAttributedString(string: description, attributes: messageAttributes)
        
        alertController.setValue(titleString, forKey: "attributedTitle")
        alertController.setValue(messageString, forKey: "attributedMessage")
        
        self.present(alertController, animated: true, completion: nil)
    }
}
