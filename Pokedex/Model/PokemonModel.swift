//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Majka on 26/10/2022.
//

import Foundation

struct PokemonModel: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let abilities: [Ability]
    let sprites: Sprite
    let types: [PokemonType]
    let stats: [Stats]
}

struct Ability: Decodable {
    let ability: AbilityName
}

struct AbilityName: Decodable {
    let name: String
}

struct Sprite: Decodable {
    let frontDefault: URL
    let other: OfficialArtwork

    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other = "other"
    }
}

struct OfficialArtwork: Decodable {
    let officialArtwork: FrontDefault
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct FrontDefault: Decodable {
    let frontDefault: URL
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonType: Decodable {
    let type: TypeName
}

struct TypeName: Decodable {
    let name: String
}

struct Stats: Decodable {
    let baseStat: Int
    let stat: Stat
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat = "stat"
    }
}

struct Stat: Decodable {
    let name: String
}

struct EvolutionModel: Decodable {
    let id: Int
    let chain: EvolutionChain
}

struct EvolutionChain: Decodable {
    let evolvesTo: [EvolutionChain]
    let species: Species
    
    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case species = "species"
    }
}

struct Species: Decodable {
    let name: String
    let url: URL
}
