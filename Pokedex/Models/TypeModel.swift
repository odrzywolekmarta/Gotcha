//
//  TypeModel.swift
//  Gotcha
//
//  Created by Majka on 07/04/2023.
//

import Foundation

struct TypeModel: Decodable {
    let damageRelations: DamageRelations
    let name: String
    let pokemon: [Pokemon]
    
    enum CodingKeys: String, CodingKey {
        case damageRelations = "damage_relations"
        case name = "name"
        case pokemon = "pokemon"
    }
}

struct DamageRelations: Decodable {
    let doubleDamageFrom: [Results]
    let doubleDamageTo: [Results]
    let halfDamageFrom: [Results]
    let halfDamageTo: [Results]
    let noDamageFrom: [Results]
    let noDamageTo: [Results]
    
    enum CodingKeys: String, CodingKey {
        case doubleDamageFrom = "double_damage_from"
        case doubleDamageTo = "double_damage_to"
        case halfDamageFrom = "half_damage_from"
        case halfDamageTo = "half_damage_to"
        case noDamageFrom = "no_damage_from"
        case noDamageTo = "no_damage_to"
    }
}

struct Pokemon: Decodable {
    let pokemon: PokemonName
}

struct PokemonName: Decodable {
    let name: String
    let url: String
}
