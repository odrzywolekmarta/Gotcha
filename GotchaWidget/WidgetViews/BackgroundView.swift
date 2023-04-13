//
//  BackgroundView.swift
//  GotchaWidgetExtension
//
//  Created by Majka on 25/03/2023.
//

import SwiftUI
import WidgetKit

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Image(WidgetConstants.light)
                .resizable()
                .scaledToFit()
            Image(WidgetConstants.pokeball)
                .renderingMode(.template)
                .resizable()
                .scaledToFill()
                .foregroundColor(.white)
                .opacity(WidgetConstants.pokeballOpacity)
        }
        .background(Color(WidgetConstants.customRed))
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
