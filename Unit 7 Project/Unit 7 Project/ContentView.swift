//
//  ContentView.swift
//  Unit 7 Project
//
//  Created by Sol Kim on 2/8/22.
//

// Sources Cited/Used:
//1) https://www.hackingwithswift.com/example-code/system/how-to-make-the-device-vibrate
//2) https://www.hackingwithswift.com/read/0/11/functions
//3) https://stackoverflow.com/questions/57571107/swiftui-navigationlink-button-is-gray-and-untouchable
//4) https://www.hackingwithswift.com/books/ios-swiftui/making-vibrations-with-uinotificationfeedbackgenerator-and-core-haptics
//5) https://www.raywenderlich.com/10608020-getting-started-with-core-haptics
//6) https://issuu.com/robertpaterson/docs/standard-metronome-timings-and-rati
//7) https://www.fivestars.blog/articles/button-styles/
//8) https://www.hackingwithswift.com/example-code/system/measuring-execution-speed-using-cfabsolutetimegetcurrent
//9) https://stackoverflow.com/questions/43703823/how-to-find-the-average-value-of-an-array-swift

import SwiftUI
import AVFoundation
import CoreHaptics

// Constants used for scaling
let sWidth = UIScreen.main.bounds.width
let sHeight = UIScreen.main.bounds.height

struct ContentView: View {
    // Default user is 4/4 time, 120 bpm, tink sound, green flash, and quarter note subdivision
    @StateObject var userModel = UserModel(user: UserItem(numerator: 4, denominator: 4, bpm: 120, sound: "tink", flashcolor: [0,255,0], subdivision: 60.0))
    
    var body: some View {
        NavigationView {
            MetronomeApp(userModel: userModel)
                .navigationBarHidden(true)
        }
    }
}

// From: https://www.hackingwithswift.com/example-code/system/how-to-make-the-device-vibrate
// Vibrating function
extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

// Function that turns the usermodel color values (array of ints) into a color
func colorinator(carray: [Int]) -> Color {
    return Color(red: Double(CGFloat(carray[0])/255), green: Double(CGFloat(carray[1])/255), blue: Double(CGFloat(carray[2])/255))
}
