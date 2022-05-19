//
//  TopBar.swift
//  Unit 7 Project
//
//  Created by Sol Kim on 2/17/22.
//

import SwiftUI

// constant for the height of the top navigationbar
let barHeight = sHeight*(0.15)

struct TopBar: View {
    @ObservedObject var userModel: UserModel
    
    var body: some View {
        HStack {
            TimeSignature(userModel: userModel)
                .padding(barHeight*(0.1))
                .accessibilityLabel("Time signature")
                .accessibility(addTraits: .isButton)
            
            BPM(userModel: userModel)
                .padding(barHeight*(0.1))
                .accessibilityLabel("Beats per Minute")
                .accessibility(addTraits: .isButton)
            
            SettingsButton(userModel: userModel)
                .padding(barHeight*(0.1))
                .accessibilityLabel("Settings")
                .accessibility(addTraits: .isButton)
        }
        .padding(.top, barHeight*(0.5))
        .padding(.bottom, barHeight*(0.1))
        .frame(width: sWidth, height: barHeight)
    }
}
