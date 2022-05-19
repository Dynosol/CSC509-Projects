//
//  SettingScreen.swift
//  Unit 6 Project
//
//  Created by Sol Kim on 1/18/22.
//

import SwiftUI

struct SettingScreen: View {
    @ObservedObject var playerModel: PlayerModel
    
    @State private var showWarning = false
    
    var body: some View {
        VStack {
            TitleBar(playerModel: playerModel)
            
            Form {
                Section {
                    TextField("Change Username", text: $playerModel.username)
                        .disableAutocorrection(true)
                    Toggle("View alert on open?", isOn: $playerModel.showPopups)
                }
                
                Section {
                    // Reset to user defaults button
                    Button {
                        showWarning = true
                    } label: {
                        Text("RESET TO DEFAULTS")
                            .foregroundColor(.red)
                    }
                    // Warns user, because this resets everything
                    .alert(isPresented: $showWarning) {
                        Alert(
                            title: Text("Are you absolutely sure?"),
                            primaryButton: .default(Text("No"), action: {}),
                            secondaryButton:
                                .default(Text("Yes, reset everything").foregroundColor(.red),
                                  
                            action: {
                                // Resetting playermodel
                                playerModel.cards = []
                                playerModel.coins = 0
                                playerModel.inv = defaultShop
                                playerModel.username = "Default Name"
                                playerModel.showPopups = true
                                playerModel.myColor = [255, 214, 89]
                                playerModel.logons = 0
                            })
                        )
                    }
                }
            }
            Text("© SolBook 2022")
        }
        .background(Color.backgroundColor)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
