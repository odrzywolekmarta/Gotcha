//
//  PokemonView.swift
//  GotchaWidgetExtension
//
//  Created by Majka on 25/03/2023.
//

import SwiftUI
import WidgetKit

struct PokemonView: View {
    @State var image = UIImage(named: WidgetConstants.placeholderImage)
    
    var body: some View {
        VStack {
            StrokeText(text: WidgetConstants.topText, width: WidgetConstants.textWidth, color: Color(WidgetConstants.customOrange))
                .font(.custom(WidgetConstants.customFont, size: WidgetConstants.fontSize))
                .foregroundColor(.black)

            PokeImage(image: image)

            StrokeText(text: WidgetConstants.bottomText, width: WidgetConstants.textWidth, color: Color(WidgetConstants.customOrange))
                .font(.custom(WidgetConstants.customFont, size: WidgetConstants.fontSize))
                .foregroundColor(.black)
                
        } // vstack
        .padding()
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
