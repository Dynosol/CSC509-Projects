//
//  ImprovedDesign.swift
//  Unit 4 Project
//
//  Created by Sol Kim on 11/8/21.
//

import SwiftUI

// Colors used for the cards in the improved design
let cardColors2 = [Color.lightBlue, Color.lime, Color.yellow, Color.niceBlue, Color.black]

// Struct containing the improved version of the given design
struct ImprovedDesign: View {
    @State var explanationMode = false
    @State var cardON: [Bool] = [true, true, true, true, true]
    @State var tempValue: Int = 22
    
    var body: some View {
        ZStack {
            Color.lightGrey
            // Main body (non-critique elements)
            VStack {
                Spacer()
                
                // Title Bar
                HStack {
                    // Changing image aspect ratio learned from:
                    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-adjust-the-way-an-image-is-fitted-to-its-space
                    Image(systemName: "chevron.left")
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal)
                        .frame(width: sWidth/4, alignment: .leading)
                    
                    Text("Living Room")
                        .font(.title)
                        .frame(width: sWidth/2)
                    
                    Spacer()
                }
                .frame(width: sWidth, height: 0.08*sHeight)
                .padding(.top)
                
                // Column of different devices
                ScrollView {
                    VStack {
                        ForEach((0...4), id: \.self) {
                            GoodDeviceCardView(index: $0, title: deviceNames[$0], color: cardColors2[$0], isOn: $cardON, temperature: $tempValue)
                            }
                    }
                    .frame(width: sWidth, height: 0.78*sHeight)
                }
                .padding(0)
                
                Spacer()
            }
            
            // Explanation View
            if explanationMode {
                Color.black.opacity(0.8)
                
                CritiqueCircle(xoff: 0, yoff: scale(-360), textyoff: 0, circleSize: sWidth/5, align: 2, exp: "No more useless white space")
                
                CritiqueCircle(xoff: scale(-180), yoff: scale(-320), textyoff: scale(35), circleSize: sWidth/10, align: 1, exp: "Added a way to subtract devices which the app needed")
                
                CritiqueCircle(xoff: scale(-110), yoff: scale(-200), textyoff: scale(90), circleSize: sWidth/5, align: 1, exp: "Now the add/subtract temperature buttons are a different color than the background, letting them stand out")
                
                CritiqueCircle(xoff: 0, yoff: scale(-200), textyoff: scale(30), circleSize: sWidth/4, align: 2, exp: "The formatting of temperature (not repeating \"Cooling\" and having the celsius sign next it) makes it easier to look at and quicker to read")
                
                CritiqueCircle(xoff: scale(-130), yoff: scale(170), textyoff: scale(-80), circleSize: sWidth/5, align: 1, exp: "The device name is now larger, making it easy to notice. There is also little icons to help identify devices quickly.")
                
                CritiqueCircle(xoff: scale(130), yoff: scale(40), textyoff: scale(-80), circleSize: sWidth/4, align: 2, exp: "The toggle buttons are now large and have a unique color identifier which indicates interactivity.")
                
                CritiqueCircle(xoff: scale(-40), yoff: scale(200), textyoff: scale(80), circleSize: sWidth/6, align: 1, exp: "The device cards are now more compact, reducing useless whitespace and showing more information on one screen (while not overcomplicating)")
                
                CritiqueCircle(xoff: scale(125), yoff: scale(300), textyoff: scale(-80), circleSize: sWidth/5, align: 2, exp: "The \"Add Devices\" card is now simplified, making it stand out and easy to understand (the button uses the special interactive-signifying blue)")
            }
            
            // Toggle critique mode
            Button(action: {
                explanationMode.toggle()
            }, label: {
                Text("Explain")
                    .font(.bold(.body)())
            })
            .offset(x: (sWidth/2)-(sWidth/8), y: -(sHeight/2)+(0.07*sHeight))
        }
        .ignoresSafeArea()
    }
}

struct ImprovedDesign_Previews: PreviewProvider {
    static var previews: some View {
        ImprovedDesign()
    }
}
