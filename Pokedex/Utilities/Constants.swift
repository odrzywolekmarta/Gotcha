//
//  Constants.swift
//  Pokedex
//
//  Created by Majka on 09/11/2022.
//

import Foundation
import UIKit

struct Constants {
    // FONTS
    static let customFont = "Orbitron-Regular"
    static let customFontBold = "Orbitron-Bold"
    static let abilityButtonFont = UIFont(name: Constants.customFontBold, size: 17)
    
    // URL STRINGS
    static let basePokemonUrl = "https://pokeapi.co/api/v2/pokemon/"
    static let baseAbilityUrl = "https://pokeapi.co/api/v2/ability/"
    static let pokemonGifUrl = "https://78.media.tumblr.com/c15b061360fa577cfa6fa1868bc45962/tumblr_o2d65b8VYl1so9b4uo1_500.gif"
    static let pokemonDetailsImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
    static let baseImageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    
    // SIZES
    static let cellRadius: CGFloat = 25
    static let cardViewRadius: CGFloat = 50
    static let barTitleFontSize: CGFloat  = 23
    static let firstBatchOfPokemon: Int = 904
    static let numberOfEmptyIds: Int = 9096
    
    // IMAGES
    static let heartImage = UIImage(systemName: "heart")
    static let heartFillImage = UIImage(systemName: "heart.fill")
    static let unknownPokemonImage = UIImage(named: "unknown")
    static let listBulletImage = UIImage(systemName: "list.bullet")
    static let magnifyingGlassImage = UIImage(systemName: "magnifyingglass")
    
    // TITLES
    static let tabNameAll = "all"
    static let tabNameFavourites = "favourites"
    static let tabNameSearch = "search"
    static let gotcha = "gotcha"
    
    // COLORS
    static let abilityButtonFontColor = UIColor(named: Constants.Colors.customRed)?.darker(by: 20)
    
    struct Colors {
        static let customRed = "CustomRed"
        static let customBeige = "CustomBeige"
        static let customBlue = "CustomBlue"
        static let customOrange = "CustomOrange"
        static let customPeach = "CustomPeach"
    }
}

// TYPE COLORS
enum PokemonAPIType: String {
    case normal
    case fire
    case water
    case grass
    case electric
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dark
    case dragon
    case steel
    case fairy
    
    var colorName: String {
        "\(self.rawValue.capitalized)Type"
    }
    
}
