//
//  PokeImageService.swift
//  GotchaWidgetExtension
//
//  Created by Majka on 29/03/2023.
//

import Foundation
import UIKit

struct PokemonImageService {
    enum PokemonImageServiceError: Error {
        case imageDataCorrupted
    }
    
    private static var cachePath: URL {
        URL.cachesDirectory.appending(path: WidgetConstants.cachePath)
    }
    
    static var cachedPokemon: UIImage? {
        guard let imageData = try? Data(contentsOf: cachePath) else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    static var cachedPokemonAvailable: Bool {
        cachedPokemon != nil
    }
    
    private static func cache(_ imageData: Data) async throws {
        try imageData.write(to: cachePath)
    }
    
    static func fetchRandomPokemon() async throws -> UIImage {
        let randomId = getRandomId()
        
        // save id to user defaults to open details view from deeplink
        UserDefaults(suiteName: WidgetConstants.appGroup)?.set(randomId, forKey: WidgetConstants.idDefaultsKey)
        
        let url = getPokeUrl(forId: randomId)
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let pokemon = try JSONDecoder().decode(PokeImageModel.self, from: data)
      
        let (imageData, _) = try await URLSession.shared.data(from: pokemon.sprites.other.officialArtwork.frontDefault)
        
        guard let image = UIImage(data: imageData) else {
            throw PokemonImageServiceError.imageDataCorrupted
        }

        Task {
            try? await cache(imageData)
        }

        return image
    }
}
