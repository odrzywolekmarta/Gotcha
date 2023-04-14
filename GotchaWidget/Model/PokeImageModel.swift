//
//  PokeImageModel.swift
//  GotchaWidgetExtension
//
//  Created by Majka on 29/03/2023.
//

import Foundation

struct PokeImageModel: Decodable {
    let sprites: Sprite
}

struct Sprite: Decodable {
    //    let frontDefault: URL
    let other: OfficialArtwork
    //    enum CodingKeys: String, CodingKey {
    //        case frontDefault = "front_default"
    //    }
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
