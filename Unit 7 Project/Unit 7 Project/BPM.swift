//
//  BPM.swift
//  Unit 7 Project
//
//  Created by Sol Kim on 2/24/22.
//

import SwiftUI

// Standardized Metromome Markings
// Taken from: https://issuu.com/robertpaterson/docs/standard-metronome-timings-and-rati
let standardMarkings = [40,42,44,46,48,50,52,54,56,58,60,63,66,69,72,76,80,84,88,92,96,100,104,108,112,116,120,126,132,138,144,152,160,168,176,184,192,200,208]

// Displays the BPM and can be edited
struct BPM: View {
    @ObservedObject var userModel: UserModel
    
    var body: some View {
        NavigationLink(destination: BPMPicker(userModel: userModel)) {
            Text("\(userModel.user.bpm) bpm")
                .font(.system(size: barHeight*(0.35)))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// User chooses bpm
struct BPMPicker: View {
    @ObservedObject var userModel: UserModel
    
    var body: some View {
        Form {
            Section {
                // Picker between conventional markings
                Picker(selection: $userModel.user.bpm, label: Text("BPM")) {
                    ForEach(standardMarkings, id: \.self) {
                        Text(String($0))
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .navigationTitle("BPM")
            }
        }
    }
}
