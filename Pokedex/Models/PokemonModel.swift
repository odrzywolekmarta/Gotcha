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
    let species: Species
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

struct SpeciesModel: Decodable {
    let evolutionChain: Chain
    let flavorTextEntries: [FlavorText?]
    
    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
        case flavorTextEntries = "flavor_text_entries"
    }
}

struct FlavorText: Decodable {
    let flavorText: String?
    let language: LanguageName?
    let version: VersionName?
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language = "language"
        case version = "version"
    }
}

struct VersionName: Decodable {
    let name: String
}

struct Chain: Decodable {
    let url: URL
}

struct AbilityModel: Decodable {
    let effectEntries: [EffectEntries]
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
        case name = "name"
    }
}

struct EffectEntries: Decodable {
    let language: LanguageName
    let shortEffect: String
    
    enum CodingKeys: String, CodingKey {
        case shortEffect = "short_effect"
        case language = "language"
    }
}

struct LanguageName: Decodable {
    let name: String
}

// model persisted in user defaults
struct PersistedModel: Codable, Hashable {
    var id: Int
    var name: String
}



