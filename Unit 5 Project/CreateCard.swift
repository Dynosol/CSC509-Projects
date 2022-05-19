//
//  CreateCard.swift
//  Unit 5 Project
//
//  Created by Sol Kim on 12/10/21.
//

import SwiftUI

struct CreateCard: View {
    // State object learned from: (this was also used in my Unit 3 Project)
    // https://developer.apple.com/documentation/swiftui/stateobject
    @StateObject var formInfo = FormSubmission()
//    @Binding var cards: [CardProperties]
    @Binding var cardModel: CardModel
    
    var body: some View {
        ZStack {
            ScrollView {
                // VStack of different form options for the user to input information
                VStack (spacing: sHeight*(0.02)) {
                    // Title bar -- vstack within vstack to create background rectangle and separation
                    VStack {
                        Text("Create Post")
                            .font(.custom("", size: sHeight*(0.04)).bold())
                            .padding(.top, sHeight*(0.05))
                    }
                    .frame(width: sWidth, height: sHeight*(0.14))
                    .background(Color.lightGrey)
                    
                    TextInput(text: "Name or Alias", variable: $formInfo.name)
                    TextInput(text: "Song Name", variable: $formInfo.songName)
                    TextInput(text: "Genre Name", variable: $formInfo.genre)
                    
                    // Toggle which sets favorited state
                    VStack {
                        Toggle(isOn: $formInfo.favorite, label: {
                            Text("Mark as favorite?")
                        })
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                        .padding()
                    }
                    .frame(width: sWidth*0.9, height: sWidth*0.1)
                    .background(Color.lightGrey)
                    .cornerRadius(sWidth*0.02)
                }
                
                // Appends new CardProperties object to the binding cards list and erases forms
                Button("Create Post") {
                    cardModel.cards.append(CardProperties(index: cardModel.cards.count, profPic: Int.random(in: 2..<22), name: formInfo.name, songName: formatSongName(name: formInfo.songName), genre: formInfo.genre, favorite: formInfo.favorite))
                    
                    formInfo.name = ""
                    formInfo.songName = ""
                    formInfo.genre = ""
                    formInfo.favorite = false
                }
                .padding()
                .background(Color.inputBackground)
                .clipShape(Capsule())
                .disabled(!checkIfFilled(form: formInfo))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bgGrey)
        .ignoresSafeArea()
    }
}

// Text Input Box
struct TextInput: View {
    var text: String
    var variable: Binding<String>
    
    var body: some View {
        // TextField learned from:
        // https://developer.apple.com/documentation/swiftui/textfield
        TextField(text, text: variable)
            .contentShape(Rectangle())
            .padding()
            .disableAutocorrection(true)
            .frame(width: sWidth*(0.95), height: sHeight*(0.05))
            .background(Color.lightGrey)
            .cornerRadius(sWidth*(0.02))
            .padding(.horizontal, sHeight*(0.01))
    }
}

// Code based on: (this was also used in my Unit 3 Project)
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
// Form input data object that gets passed from view to view
class FormSubmission: ObservableObject {
    @Published var name = ""
    @Published var songName = ""
    @Published var genre = ""
    @Published var favorite = false
}

// Checks if minimum info is filled out in the form -- name, song name, and genre
func checkIfFilled(form: FormSubmission) -> Bool {
    if (form.name != "") && (form.songName != "") && (form.genre != "") {
        return true
    }
    return false
}

// Makes sure the song name on the card has quotation marks around it
func formatSongName(name: String) -> String {
    var tempName = name
    
    // Learned first and last elements from:
    // https://www.agnosticdev.com/content/how-get-first-or-last-characters-string-swift-4
    if name.prefix(1) != "'" {
        tempName = "'\(tempName)"
    }
    if name.suffix(1) != "'" {
        tempName = "\(tempName)'"
    }
    return tempName
}
