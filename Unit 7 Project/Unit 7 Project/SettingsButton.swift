//
//  SettingsButton.swift
//  Unit 7 Project
//
//  Created by Sol Kim on 2/24/22.
//

import SwiftUI

// Sound options set in metronome app
let soundoptions = ["tick", "tock", "dmf", "slh", "tink"]
// green, red, pink, blue, white
let flashcolors = [[0,255,0], [255,0,0], [255,20,147], [0,0,250], [255,255,255]]
// What is displayed the user
let colorToName = [
    [0,255,0]: "Green",
    [255,0,0]: "Red",
    [255,20,147]: "Pink",
    [0,0,250]: "Blue",
    [255,255,255]: "White"
]
// constants to divide the beat by (sixteenth, eighth, quarter, etc)
let subdivisions = [15.0, 30.0, 60.0, 120.0, 240.0]
// converts those constants into text to display in picker
let divisionToText = [
    15.0: "16th",
    30.0: "8th",
    60.0: "Quarter",
    120.0: "Half",
    240.0: "Whole"
]

// The button which directs to the settings screen
struct SettingsButton: View {
    @ObservedObject var userModel: UserModel
    
    var body: some View {
        NavigationLink(destination: SettingsScreen(userModel: userModel), label: {
            Image(systemName: "gearshape")
                .font(.system(size: barHeight*(0.35)))
        })
        .buttonStyle(PlainButtonStyle())
    }
}

// Settings form
struct SettingsScreen: View {
    @ObservedObject var userModel: UserModel
    
    var body: some View {
        Form {
            // Beep sound choice
            Section {
                Picker(selection: $userModel.user.sound, label: Text("Sound Option")) {
                    ForEach(soundoptions, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            // Beep flash color choice
            Section {
                Picker(selection: $userModel.user.flashcolor, label: Text("Flash color Option")) {
                    ForEach(flashcolors, id: \.self) {
                        Text(colorToName[$0] ?? "none")
                    }
                }
            }
            
            // Beep subdivision choice
            Section {
                Picker(selection: $userModel.user.subdivision, label: Text("Sound subdivision")) {
                    ForEach(subdivisions, id: \.self) {
                        Text(divisionToText[$0] ?? "none")
                    }
                }
            }
        }.navigationBarTitle("User Settings")
    }
}
