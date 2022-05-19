//
//  LowFriction.swift
//  Unit 3 Project
//
//  Created by Sol Kim on 10/25/21.
//

import SwiftUI

struct LowFriction: View {
    var body: some View {
        NavigationView {
            VStack {
                FormView(friction: 1)
            }
            .navigationBarItems(
                leading: NavigationLink ("Scenario",
                    destination: ScenarioExplanation()
                ),
                trailing: NavigationLink ("Explanation",
                    destination: LowFrictionExplanation()
                )
            )
        }
        .navigationBarHidden(true)
    }
}

struct LowFrictionExplanation: View {
    var body: some View {
        ZStack {
            InfoTextView(text: "This form has low friction because of no user input validation and lack of options. There is no check to whether the user has inputted information for the name, song name, and song length boxes. The user is then able to create an empty post, which we will assume that they don't want to do. The minimum friction allows the user to perform an action easily that they don't want to (or shouldn't) do. Also, there is a low amount of privacy questions for the user to answer. More privacy questions would provide more friction, but friction that (ethically) we want for the user.")
        }
        .frame(width: sWidth, height: sHeight)
        .background(Color.background)
        .ignoresSafeArea()
    }
}

struct BackgroundRectanglesView: View {
    var color: Color
    var border: CGFloat
    
    var body: some View {
        Rectangle()
            .foregroundColor(self.color)
            .frame(width: sWidth-self.border, height: (400/414)*sWidth-self.border)
            .cornerRadius((10/414)*sWidth)
    }
}

struct LowFriction_Previews: PreviewProvider {
    static var previews: some View {
        LowFriction()
    }
}
