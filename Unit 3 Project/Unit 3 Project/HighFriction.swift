//
//  HighFriction.swift
//  Unit 3 Project
//
//  Created by Sol Kim on 10/25/21.
//

import SwiftUI

struct HighFriction: View {
    var body: some View {
        NavigationView {
            VStack {
                FormView(friction: 3)
            }
            .navigationBarItems(
                leading: NavigationLink ("Scenario",
                    destination: ScenarioExplanation()
                ),
                trailing: NavigationLink ("Explanation",
                    destination: HighFrictionExplanation()
                )
            )
        }
        .navigationBarHidden(true)
    }
}

struct HighFrictionExplanation: View {
    var body: some View {
        ZStack {
            InfoTextView(text: "This form has high friction because of cumbersome input validation and annoying methods of inputting data. Users must select a genre name form a spinning picker wheel, which is annoying to use because of a large number of available genres. Also, the user is unable to add their own genre, if they want to put one which is not one of the available options. The slider wheel for song length may seem like it has less friction, but it limits the user's available length options and the sensitive slider is annoying to use on a small phone screen. In the privacy questions, the form forces the user to turn each toggle button on before moving on to the next button, which is extra friction. The form is also unsubmittable (the user cannot create a post) before first name AND last name are filled out, unlike the \"good fricion\" form. If a user wants to put in a single band name or an alias (like \"Adele\"), they will not be able to.")
        }
        .frame(width: sWidth, height: sHeight)
        .background(Color.background)
        .ignoresSafeArea()
    }
}

struct HighFriction_Previews: PreviewProvider {
    static var previews: some View {
        HighFriction()
    }
}
