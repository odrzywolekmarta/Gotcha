//
//  PokemonView.swift
//  GotchaWidgetExtension
//
//  Created by Majka on 25/03/2023.
//

import SwiftUI
import WidgetKit
import URLImage

struct PokemonView: View {
    var body: some View {
        VStack {
            Text("WHO'S THAT")
                .font(.system(size: 12))
                .fontWeight(.black)
                .scaledToFit()
            
            // image
            
         

            
            Text("POKEMON?")
                .font(.system(size: 12))
                .fontWeight(.black)
        } // vstack
        
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
