//
//  CenterBody.swift
//  Unit 7 Project
//
//  Created by Sol Kim on 2/17/22.
//

import SwiftUI
import Combine
import AVFoundation

// Height of the center body - constant
let bodyHeight = sHeight*(0.65)

struct CenterBody: View {
    @ObservedObject var userModel: UserModel
    
    // tick is value sent in that is triggered every metronome tick
    @Binding var tick: Bool
    @Binding var runningCount: Int
    // Bool that changes for the background color to flash
    @State var color: Bool = false
    // Number of times the TAP was clicked; to apply into functions
    @State var clickedNum: Int = 0
    // time that starts when TAP button is first clicked, used to compare future clicks to gather timing
    @State var start: CFAbsoluteTime = 0
    // Store time between clicks here
    @State var averages: [CFAbsoluteTime] = []
    
    // refreshes view to account for the TAP function
    let refresher = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    // running count used for the flashing circles: modular function to get the measure numbers
    var rCount: Int {
        runningCount % userModel.user.numerator
    }

    var body: some View {
        // Plain style to fix formatting learned from: https://www.fivestars.blog/articles/button-styles/
        Button {
            // Start timer if button has not been clicked recently
            // Measuring time from: https://www.hackingwithswift.com/example-code/system/measuring-execution-speed-using-cfabsolutetimegetcurrent
            if clickedNum > 0 {
                averages.append(CFAbsoluteTimeGetCurrent() - start)
                // Learned average method from: https://stackoverflow.com/questions/43703823/how-to-find-the-average-value-of-an-array-swift
                userModel.user.bpm = Int(60.0/(Double(averages.reduce(0, +)) / Double(averages.count)))
            }
            start = CFAbsoluteTimeGetCurrent()
            clickedNum += 1
        } label: {
            // Center body main view
            ZStack {
                // Color should flash on every beat and turn black between beats
                color ? colorinator(carray: userModel.user.flashcolor) : Color.black
                
                VStack {
                    ZStack {
                        // Background for the flashing circles
                        Rectangle()
                            .frame(width: sWidth*(0.9), height: (sWidth/CGFloat(userModel.user.numerator))*(0.6)+(sHeight*(0.05)))
                            .foregroundColor(Color.black)
                            .cornerRadius(sWidth*(0.05))
                        
                        // Flashing circles that change color for beats
                        HStack {
                            ForEach(0..<userModel.user.numerator, id: \.self) { i in
                                FlashingButton(userModel: userModel, index: i, rCount: rCount)
                            }
                        }
                    }
                    .padding(.top, bodyHeight*(0.1))
                    
                    Spacer()
                }

                // Tap label
                Text("TAP")
                    .font(.system(size: bodyHeight*(0.2)))
                    .foregroundColor(.white)
                    .accessibilityLabel("Tap")
            }
            .onChange(of: tick) { _ in
                // Turn on the color
                color = true
                // Remain colorized for 0.1 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    color = false
                }
            }.frame(width: sWidth, height: bodyHeight)
        }
        .buttonStyle(PlainButtonStyle())
        // Direct interaction for the TAP tempo set function
        .accessibility(addTraits: .allowsDirectInteraction)
        // Announces direct interaction after a few seconds of delay in voiceover
        .accessibility(hint: Text("Interact with single tap"))
        .onReceive(refresher) {_ in
            // Check if button has been clicked in the past two seconds
            if (CFAbsoluteTimeGetCurrent() - start) > 2 {
                // Reset the averages array and click counter
                clickedNum = 0
                averages = []
            }
            // If the number of clicks is long, remove the first few clicks to not interfere with average
            if averages.count > 5 {
                averages.remove(at: 0)
            }
        }
    }
}

struct FlashingButton: View {
    @ObservedObject var userModel: UserModel

    var index: Int
    var rCount: Int

    // Reminder about functions from: https://www.hackingwithswift.com/read/0/11/functions
    func circleSizer(num: Int) -> CGFloat {
        return (sWidth/CGFloat(num))*(0.6)
    }

    var body: some View {
        ZStack {
            Circle()
                // make the circle green if the beat is on the numerator
                .foregroundColor(index + 1 <= rCount || rCount == 0 ? .green : .gray)
                .frame(width: circleSizer(num: userModel.user.numerator), height: circleSizer(num: userModel.user.numerator))
        }
    }
}
