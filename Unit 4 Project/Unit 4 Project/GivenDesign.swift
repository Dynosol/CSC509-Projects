//
//  GivenDesign.swift
//  Unit 4 Project
//
//  Created by Sol Kim on 11/8/21.
//

import SwiftUI

let deviceNames = ["AC", "Light", "Speaker", "TV", "Mic"]
let cardColors = [Color.lightBlue, Color.lime, Color.black]

// Struct containing a mimicry of the given design
struct GivenDesign: View {
    @State var critiqueModeOn = false
    @State var tempValue: Int = 22
    
    var body: some View {
        ZStack {
            // Main body (non-critique elements)
            VStack {
                Spacer()
                
                // Title Bar
                HStack {
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
                
                
                // Devices List
                Text("Devices")
                    .padding(.horizontal)
                    .frame(width: sWidth, height: 0.04*sHeight, alignment: .leading)
                    .font(.bold(.title)())
                
                ScrollView {
                    VStack {
                        ForEach((0...2), id: \.self) {
                            BadDeviceCardView(index: $0, title: deviceNames[$0], color: cardColors[$0], temperature: $tempValue)
                            }
                    }
                    .frame(width: sWidth, height: 0.8*sHeight)
                }
            }
            
            // Critique elements
            if critiqueModeOn {
                // Overlay opacity learned from:
                // https://stackoverflow.com/questions/68697255/how-to-set-the-opacity-of-an-overlay-in-swiftui
                Color.black.opacity(0.8)
                
                CritiqueCircle(xoff: scale(-140), yoff: scale(-10), textyoff: 70, circleSize: sWidth/5, align: 1, exp: "This size and boldness of font makes the name of the device difficult to locate immediately on the screen.")
                
                CritiqueCircle(xoff: scale(140), yoff: 0, textyoff: scale(80), circleSize: sWidth/5, align: 2, exp: "The purple color of the toggle button is reused elsewhere as decoration, making the color have less meaning and not stand out. The toggle buttons are too small and could be hard to press for some users")
                
                CritiqueCircle(xoff: 0, yoff: scale(-350), textyoff: 0, circleSize: sWidth/5, align: 2, exp: "Too much white space here")
                
                CritiqueCircle(xoff: scale(-140), yoff: scale(-330), textyoff: scale(65), circleSize: sWidth/4, align: 1, exp: "Unneeded text, we know that we are seeing devices here")
                
                CritiqueCircle(xoff: scale(-120), yoff: scale(-170), textyoff: scale(60), circleSize: sWidth/5, align: 1, exp: "The buttons to add and subtract are the same color as the background, making them blend in and hard to see")
                
                CritiqueCircle(xoff: 0, yoff: scale(360), textyoff: scale(-70), circleSize: sWidth/4, align: 0, exp: "Again, white is used to indicate interaction but is also the color of the background")
                
                CritiqueCircle(xoff: 0, yoff: scale(-220), textyoff: 0, circleSize: sWidth/5, align: 2, exp: "The text \"Cooling\" is unnecessary and the Celcius symbol should be next to the temperature")
                
                CritiqueCircle(xoff: scale(-140), yoff: scale(140), textyoff: scale(65), circleSize: sWidth/6, align: 0, fullWidth: 1, exp: "Each device card takes up too much space on the screen, this would be infuriating to navigate with more devices. Also it's awkward to have the highly detailed image of a light while there is no other detailed image anywhere else")
            }
            
            // Toggle critique mode
            Button(action: {
                critiqueModeOn.toggle()
            }, label: {
                Text("Critique")
                    .font(.bold(.body)())
            })
            .offset(x: (sWidth/2)-(sWidth/8), y: -(sHeight/2)+(0.07*sHeight))
        }
        .ignoresSafeArea()
    }
}

// Yellow outline around areas within the critique screen with corresponding text
struct CritiqueCircle: View {
    var xoff: CGFloat
    var yoff: CGFloat
    var textyoff: CGFloat
    var circleSize: CGFloat
    var align: Int
    var fullWidth: Int = 0
    var exp: String
    
    // 1 indicates left aligned, 2 indicates right aligned, other indicates center aligned
    var leftShift: CGFloat {
        if align == 1 {
            return -(sWidth/2)/2
        }
        if align == 2 {
            return (sWidth/2)/2
        }
        else {
            return 0
        }
    }
    
    // Width of the frame containing the text
    var widthSet: CGFloat {
        if fullWidth == 1 {
            return sWidth
        } else {
            return sWidth/2
        }
    }
    
    // This value indicates where on the screen the text should align
    var multiAlign: TextAlignment {
        if align == 1 {
            return .leading
        }
        if align == 2 {
            return .trailing
        }
        else {
            return .center
        }
    }
    
    var body: some View {
        ZStack {
            // yellow critique circle
            Circle()
                .stroke(Color.yellow.opacity(0.5), lineWidth: sWidth/100)
                .frame(width: circleSize, height: circleSize)
                .offset(x: xoff)
            
            //Critique text
            Text(exp)
                .font(.system(size: sWidth/30))
                .foregroundColor(.white)
                .offset(x: leftShift, y: textyoff)
                .frame(width: widthSet)
                .multilineTextAlignment(multiAlign)
        }
        .frame(height: sHeight/5)
        .offset(y: yoff)
    }
}

struct GivenDesign_Previews: PreviewProvider {
    static var previews: some View {
        GivenDesign()
    }
}
