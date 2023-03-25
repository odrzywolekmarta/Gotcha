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
            Image("light2")
                .resizable()
                .scaledToFit()
        }
        .background(RadialGradient(colors:  [Color("CustomBlue"), Color("CustomRed")], center: .center, startRadius: 25, endRadius: 60))
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
