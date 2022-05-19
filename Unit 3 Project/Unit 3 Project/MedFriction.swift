//
//  MedFriction.swift
//  Unit 3 Project
//
//  Created by Sol Kim on 10/25/21.
//

import SwiftUI

struct MedFriction: View {
    var body: some View {
        NavigationView {
            VStack {
                FormView(friction: 2)
            }
            .navigationBarItems(
                leading: NavigationLink ("Scenario",
                    destination: ScenarioExplanation()
                ),
                trailing: NavigationLink ("Explanation",
                    destination: MedFrictionExplanation()
                )
            )
        }
        .navigationBarHidden(true)
    }
}

struct MedFrictionExplanation: View {
    var body: some View {
        ZStack {
            InfoTextView(text: "This form has a good amount of friction because a comfortable amount of input validation and a comfortable amount of required questions. For example, the user is not able to post without having something in the name, song name, genre name, and song length categories. The check for first and last name is combined, so users who want to put a single band name or only their first name are able to do so. There is now a 'genre name' category, which is more friction for the user who wants to create a post, but good friction because it helps other users find specific or related music. It seems like there are too many privacy questions, but they are separated into three categories. The first toggle button is the only one enabled for each category, and the options after are only available if the first one is enabled. This is to make the button-answering process a little simpler and easier to organize, and also to force a logical set of 'toggled' buttons (you cannot have a shareable song that is not public).")
        }
        .frame(width: sWidth, height: sHeight)
        .background(Color.background)
        .ignoresSafeArea()
    }
}

struct MedFriction_Previews: PreviewProvider {
    static var previews: some View {
        MedFriction()
    }
}
