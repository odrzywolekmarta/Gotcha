//
//  RandomIdGenerator.swift
//  Gotcha
//
//  Created by Majka on 25/03/2023.
//
import WidgetKit
import SwiftUI

func getRandomId() -> Int {
    Int.random(in: 1...905)
}

public func getPokeUrl(forId id: Int) -> URL {
    let idString = String(id)
    let urlString = "\(WidgetConstants.basePokemonUrl)\(idString)"
    if let url = URL(string: urlString) {
        return url
    }
    return URL(fileURLWithPath: "")
}


