//
//  File.swift
//  Gotcha
//
//  Created by Majka on 24/12/2022.
//

import Foundation

class Favourites {
    private var favouritesList: Set<PersistedModel> = []
    var favouritesArray: [PersistedModel] = []
    private let defaults = UserDefaults.standard
    private let saveKey = "Favorites"

    init() {
        fetch()
    }

    func fetch() {
        let decoder = PropertyListDecoder()
        if let data = defaults.data(forKey: saveKey) {
            let favourites = try? decoder.decode(Set<PersistedModel>.self, from: data)
            self.favouritesList = favourites ?? []
            self.favouritesArray = Array(favouritesList)
            sort()
            return
        } else {
            self.favouritesList = []
        }
    }
    
    private func sort() {
        favouritesArray.sort {
            $0.id < $1.id
        }
    }
    
    func contains(_ resort: PersistedModel) -> Bool {
        favouritesList.contains(resort)
    }

    func add(_ resort: PersistedModel) {
//        objectWillChange.send()
        favouritesList.insert(resort)
        save()
    }

    func remove(_ resort: PersistedModel) {
//        objectWillChange.send()
        favouritesList.remove(resort)
        save()
    }
    
    func clear() {
        favouritesList.removeAll()
        save()
        fetch()
    }

    func save() {
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(favouritesList) {
            defaults.setValue(encoded, forKey: saveKey)
        }
    }
}
