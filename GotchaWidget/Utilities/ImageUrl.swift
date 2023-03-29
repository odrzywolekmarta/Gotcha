//
//  RandomIdGenerator.swift
//  Gotcha
//
//  Created by Majka on 25/03/2023.
//
import WidgetKit
import SwiftUI

let baseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"

func getRandomId() -> Int {
    Int.random(in: 1...905)
}

public func getImageUrl(forId id: Int) -> URL {
    let idString = String(id)
    let urlString  = "\(baseUrl)\(idString).png"
    if let url = URL(string: urlString) {
        return url
    }
    return URL(fileURLWithPath: "")
}

