//
//  DeeplinkHandler.swift
//  Gotcha
//
//  Created by Majka on 12/04/2023.
//

import Foundation
import UIKit

protocol DeeplinkHandlerProtocol {
    func canOpenUrl(_ url: URL) -> Bool
    func getPokemonUrl(_ url: URL) -> String
}

class DetailsDeeplinkHandler: DeeplinkHandlerProtocol {
    private weak var rootViewController: UIViewController?
    private let favourites: Favourites
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
        self.favourites = Favourites()
    }
    
    func canOpenUrl(_ url: URL) -> Bool {
        return url.absoluteString.hasPrefix(Constants.detailsDeeplink)
    }
    
    func getPokemonUrl(_ url: URL) -> String {
        guard let id = UserDefaults(suiteName: Constants.appGroup)?.object(forKey: "widgetId") as? Int else {
            return ""
        }
        let urlString = "\(Constants.basePokemonUrl)\(id)"
        return urlString
    }    
}

