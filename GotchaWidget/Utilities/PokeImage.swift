//
//  PokeImage.swift
//  GotchaWidgetExtension
//
//  Created by Majka on 27/03/2023.
//

import Foundation
import SwiftUI

struct PokeImage: View {
    let url: URL?
    
    var body: some View {
        Group {
            if let url = url, let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Image("Image")
            }
        }
    }
}
