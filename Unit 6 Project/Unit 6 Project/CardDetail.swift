//
//  CardDetail.swift
//  Unit 6 Project
//
//  Created by Sol Kim on 1/19/22.
//

import SwiftUI

struct CardDetail: View {
    @ObservedObject var playerModel: PlayerModel
    var index: Int
    
    var body: some View {
        ZStack {
            Color.backgroundColor
        
            VStack {
                Text(playerModel.cards[index].title)
                    .font(.custom("", size: sHeight*0.07))
                    .multilineTextAlignment(.center)
                Text(playerModel.cards[index].desc)
                    .multilineTextAlignment(.center)
                
                DoneButton(playerModel: playerModel, index: index, text: "Complete")
            }
            .frame(width: sWidth*(0.95), height: sWidth*(0.95))
        // Edit option within the card detail
        }.navigationBarItems(trailing: NavigationLink(destination: EditOption(card: $playerModel.cards[index]), label: {Text("Edit")}))
    }
}

struct EditOption: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var card: Card
    
    // Checks if user has made a title, which is required for todo creation
    func legal(title: String) -> Bool {
        if (title != "") {
            return true
        }
        return false
    }
    
    var body: some View {
        Form {
            TextField("TODO title", text: $card.title)
                .disableAutocorrection(true)
            TextField("Card text", text: $card.desc)
                .disableAutocorrection(true)
            Toggle("High Value Target?", isOn: $card.highval)
                .disableAutocorrection(true)
            
            // save the edits
            Button("Save") {
                if legal(title: card.title) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationBarTitle("Edit")
    }
}
