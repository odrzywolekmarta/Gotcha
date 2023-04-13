//
//  PokeImage.swift
//  GotchaWidgetExtension
//
//  Created by Majka on 27/03/2023.
//

import Foundation
import SwiftUI

struct PokeImage: View {
    var image: UIImage?
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
        }
    }
}

