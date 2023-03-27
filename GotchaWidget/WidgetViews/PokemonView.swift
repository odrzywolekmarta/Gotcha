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
    @State var url: URL?
    
    var body: some View {
        VStack {
            Text("WHO'S THAT")
                .font(.custom("Orbitron-Bold", size: 15))
            
            PokeImage(url: url)
            
            StrokeText(text: "POKÉMON?", width: 1.4, color: Color("CustomOrange"))
                .font(.custom("Orbitron-Bold", size: 19))
//                .shadow(color: Color("CustomOrange"), radius: 5)
//            Text("POKÉMON?")
//                .font(Font.custom("Orbitron-Bold", size: 19))
//                .foregroundColor(.black)
                
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
