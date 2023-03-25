//
//  RandomIdGenerator.swift
//  Gotcha
//
//  Created by Majka on 25/03/2023.
//
import WidgetKit
import Foundation
import SDWebImage

let baseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"

func getRandomId() -> Int {
    Int.random(in: 1...905)
}

func getImageUrl() {
    let idString = String(getRandomId())
    let url = "\(baseUrl)\(idString).png"
}

func getShadowImage(image: UIImage) {
    let shadowImage = image.withRenderingMode(.alwaysTemplate)
    shadowImage.withTintColor(.black)
}
