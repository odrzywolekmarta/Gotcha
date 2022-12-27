//
//  File.swift
//  Gotcha
//
//  Created by Majka on 24/12/2022.
//

import Foundation

class Favorites: ObservableObject {
    var favouritesList: Set<PersistedModel>
//    var favIds: [Int]?
    let defaults = UserDefaults.standard
    private let saveKey = "Favorites"

    init() {
        let decoder = PropertyListDecoder()
        if let data = defaults.data(forKey: saveKey) {
            let favourites = try? decoder.decode(Set<PersistedModel>.self, from: data)
            self.favouritesList = favourites ?? []
            return
        } else {
            self.favouritesList = []
        }
    }

//    func getIds() -> [Int]? {
//        for fave in favouritesList {
//            favIds?.append(fave.id)
//        }
//        return favIds
//    }
    
    func contains(_ resort: PersistedModel) -> Bool {
        favouritesList.contains(resort)
    }

    func add(_ resort: PersistedModel) {
        objectWillChange.send()
        favouritesList.insert(resort)
        save()
    }

    func remove(_ resort: PersistedModel) {
        objectWillChange.send()
        favouritesList.remove(resort)
        save()
    }

    func save() {
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(favouritesList) {
            defaults.setValue(encoded, forKey: saveKey)
        }
    }
}
