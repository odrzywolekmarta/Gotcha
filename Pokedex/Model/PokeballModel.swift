//
//  PokeballModel.swift
//  Gotcha
//
//  Created by Majka on 05/05/2023.
//

import Foundation

struct ItemsList: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    let name: String
    let url: String
}

struct PokeballModel: Decodable {
    let cost: Int
    let effectEntries: [EffectEntries]
    let name: String
}


