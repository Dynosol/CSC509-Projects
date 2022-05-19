//
//  CardCreation.swift
//  Unit 6 Project
//
//  Created by Sol Kim on 1/19/22.
//

import SwiftUI

struct CardCreation: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var playerModel: PlayerModel
    
    @State private var showingAlert = false
    @State var newTitle = ""
    @State var newDesc = ""
    @State var highVal = false
    
    // Checks if user has made a title, which is required for todo creation
    func legal(title: String) -> Bool {
        if (title != "") { return true }
        return false
    }
    
    var body: some View {
        Form {
            TextField("TODO title", text: $newTitle)
                .disableAutocorrection(true)
            TextField("Card text", text: $newDesc)
                .disableAutocorrection(true)
            // Reminder about toggle from:
            // https://flaviocopes.com/swiftui-forms-toggle/
            Toggle("High Value Target?", isOn: $highVal)
            
            Button("Create Card") {
                if legal(title: newTitle) {
                    playerModel.cards.append(Card(title: newTitle, desc: newDesc, highval: highVal, completed: false))
                    newTitle = ""
                    newDesc = ""
                    
                    presentationMode.wrappedValue.dismiss()
                } else {
                    showingAlert = true
                }
            }
            // Pops up if you have entered an invalid input
            // Learned from:
            // https://sarunw.com/posts/how-to-present-alert-in-swiftui-ios13/
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("You can't do that"),
                    message: Text("Title required"),
                    dismissButton: .default(Text("Okay"), action: {})
                )
            }
        }
    }
}
