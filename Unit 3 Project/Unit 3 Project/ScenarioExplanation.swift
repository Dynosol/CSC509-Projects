//
//  ScenarioExplanation.swift
//  Unit 3 Project
//
//  Created by Sol Kim on 10/25/21.
//

import SwiftUI

struct ScenarioExplanation: View {
    var body: some View {
        VStack {
            InfoTextView(text: "Scenario")
            
            Text("This project is the post creation screen in the app SolBook. In SolBook, users can find songs and have songs/artists/genres recommended to them based on their past likes and searches. Users can also post their own songs with accompanying information (their name/alias, song name, genre, length), which is what this project is. Users can also choose options that don't appear on the post card, such as who can see their post and how users can interact with users.")
                .padding((10/896)*sHeight)
                .background(Color.inputBackground)
                .cornerRadius((6/896)*sHeight)
                .shadow(color: Color.darkShadow, radius: (3/896)*sHeight, x: (2/896)*sHeight, y: (2/896)*sHeight)
                .shadow(color: Color.lightShadow, radius: (3/896)*sHeight, x: (-2/896)*sHeight, y: (-2/896)*sHeight)
                .padding((10/896)*sHeight)
        }
        .frame(width: sWidth, height: sHeight)
        .background(Color.background)
        .ignoresSafeArea()
    }
}

struct ScenarioExplanation_Previews: PreviewProvider {
    static var previews: some View {
        ScenarioExplanation()
    }
}
