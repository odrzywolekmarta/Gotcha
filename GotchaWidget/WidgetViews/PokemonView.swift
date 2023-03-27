//
//  PokemonView.swift
//  GotchaWidgetExtension
//
//  Created by Majka on 25/03/2023.
//

import SwiftUI
import WidgetKit

struct PokemonView: View {
    @State var url: URL?
    
    var body: some View {
        VStack {
            StrokeText(text: "WHO'S THAT", width: 1.4, color: Color("CustomOrange"))
                .font(.custom("Orbitron-Bold", size: 19))
                .foregroundColor(.black)
//            Text("WHO'S THAT")
//                .font(.custom("Orbitron-Bold", size: 15))
//                .foregroundColor(.black)

            PokeImage(url: url)

            StrokeText(text: "POKÉMON?", width: 1.4, color: Color("CustomOrange"))
                .font(.custom("Orbitron-Bold", size: 19))
                .foregroundColor(.black)
                
        } // vstack
        .padding()
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        let url: URL? = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png")
        PokemonView(url: url)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
