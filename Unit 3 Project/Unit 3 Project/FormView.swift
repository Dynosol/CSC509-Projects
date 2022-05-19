//
//  FormView.swift
//  Unit 3 Project
//
//  Created by Sol Kim on 10/27/21.
//

import SwiftUI

struct FormView: View {
    @StateObject var formInfo = FormSubmission()
    @State private var buttonClicked: Int? = 0
    
    var friction: Int
    // List of genres the user can choose from
    var genres = ["Rock", "Funk Rock", "Alt Rock", "Punk Rock", "Heavy Metal", "Alt Pop", "Alternative Music", "Country", "Jazz", "Bebop", "Jazz Fusion", "Hip Hop", "R&B", "Rap", "Folk", "Soul", "Classical", "Electronic", "Reggae", "Gospel", "EDM", "Funk", "Disco", "Instrumental", "Techno", "Bluegrass", "Swing", "Ambient", "Trance", "Indie Rock", "Dubstep", "Grunge", "New Wave", "Psychedelic"]
    
    var body: some View {
        ZStack {
            ScrollView {
                // VStack of different form options for the user to input information
                VStack {
                    // Form Title
                    Text("Create Post")
                        .font(.title.bold()).foregroundColor(.textColor)
                        .padding(.top, (150/896)*sHeight)
                        .padding(.bottom, (20/896)*sHeight)
                    
                    TextInput(text: "First Name or Alias", variable: $formInfo.firstName)
                    TextInput(text: "Last Name", variable: $formInfo.lastName)
                        .padding(.bottom, (10/896)*sHeight)
                    
                    TextInput(text: "Song Name", variable: $formInfo.songName)
                    if self.friction == 2 {
                        TextInput(text: "Genre Name", variable: $formInfo.genreName)
                    }
                    
                    // Picker and Stepper only appear for high friction
                    if self.friction == 3 {
                        InfoTextView(text: "Select Genre Name")
                        Picker(selection: $formInfo.genreIndex, label: Text("Song Genre")) {
                            ForEach(0 ..< genres.count) {
                                Text(self.genres[$0])
                            }
                        }
                        
                        // Slider code based on:
                        // https://www.simpleswiftguide.com/swiftui-slider-tutorial-how-to-create-and-use-slider-in-swiftui/
                        Slider(value: $formInfo.songLength, in: 0.00...60.00)
                            .padding(.horizontal, (10/896)*sHeight)
                        Text("Song Length (about): \(formInfo.songLength, specifier: "%2.f") minutes")
                    }
                    
                    // Stepper is more convenient for songs
                    if self.friction != 3 {
                        Stepper("Song Length (about): ", value: $formInfo.songLength)
                            .padding(.horizontal, (10/896)*sHeight)
                        InfoTextView(text: "Song Length: \(Int(formInfo.songLength)) minutes")
                    }
                }
                
                // Divider rectangle
                Rectangle()
                    .foregroundColor(.darkShadow)
                
                // Second VStack required because of Swiftui limitations
                // Containing toggle questions
                VStack {
                    Text("Privacy Questions")
                        .font(.title.bold()).foregroundColor(.textColor)
                        .padding((20/896)*sHeight)
                    
                    ToggleButton(text: "Make Song Public?", variable: $formInfo.makeSongPublic)
                    
                    // GOOD FRICTION publicity questions
                    if self.friction == 2 {
                        ToggleButton(text: "Make Song Shareable?", variable: $formInfo.makeSongShareable)
                            .disabled(!formInfo.makeSongPublic)
                        ToggleButton(text: "Make Song Visable to Friends Only?", variable: $formInfo.makeSongFriendsOnly)
                            .disabled(!formInfo.makeSongPublic)
                        ToggleButton(text: "Make Song Unlisted?", variable: $formInfo.makeSongUnlisted)
                            .disabled(!formInfo.makeSongPublic)
                            .padding(.bottom, (15/896)*sHeight)
                    }
                    
                    // TOO MUCH FRICTION publicity questions
                    if self.friction == 3 {
                        ToggleButton(text: "Make Song Shareable?", variable: $formInfo.makeSongShareable)
                            .disabled(!formInfo.makeSongPublic)
                        ToggleButton(text: "Make Song Visable to Friends Only?", variable: $formInfo.makeSongFriendsOnly)
                            .disabled(!formInfo.makeSongShareable)
                        ToggleButton(text: "Make Song Unlisted?", variable: $formInfo.makeSongUnlisted)
                            .disabled(!formInfo.makeSongFriendsOnly)
                            .padding(.bottom, (15/896)*sHeight)
                    }
                    
                    ToggleButton(text: "Allow User Interaction?", variable: $formInfo.allowUserInteraction)
                    
                    // GOOD FRICTION user questions
                    if self.friction == 2 {
                        ToggleButton(text: "Allow Likes?", variable: $formInfo.allowLiking)
                            .disabled(!formInfo.allowUserInteraction)
                        ToggleButton(text: "Allow Following?", variable: $formInfo.allowFollow)
                            .disabled(!formInfo.allowUserInteraction)
                        ToggleButton(text: "Allow Song Preview?", variable: $formInfo.allowPreview)
                            .disabled(!formInfo.allowUserInteraction)
                            .padding(.bottom, (15/896)*sHeight)
                    }
                    
                    // TOO MUCH FRICTION user questions
                    if self.friction == 3 {
                        ToggleButton(text: "Allow Likes?", variable: $formInfo.allowLiking)
                            .disabled(!formInfo.allowUserInteraction)
                        ToggleButton(text: "Allow Following?", variable: $formInfo.allowFollow)
                            .disabled(!formInfo.allowLiking)
                        ToggleButton(text: "Allow Song Preview?", variable: $formInfo.allowPreview)
                            .disabled(!formInfo.allowFollow)
                            .padding(.bottom, (15/896)*sHeight)
                    }
                    
                    ToggleButton(text: "Allow SolBook to Access Your Personal Info?", variable: $formInfo.allowSolbook)
                }
                
                // Method learned from:
                // https://stackoverflow.com/questions/57130866/how-to-show-navigationlink-as-a-button-in-swiftui
                NavigationLink(destination: DisplayView(formInfo: formInfo), tag: 1, selection: $buttonClicked) {
                    EmptyView()
                }
                
                // Button disable feature exists only for frictions higher than lowest friction
                if self.friction == 2 {
                    Button("Create Post") {
                        buttonClicked = 1
                    }
                    .padding()
                    .background(Color.inputBackground)
                    .clipShape(Capsule())
                    .disabled(!checkIfFilled(form: formInfo))
                }
                // Too much friction requires you to put a last name
                else if self.friction == 3 {
                    Button("Create Post") {
                        buttonClicked = 1
                    }
                    .padding()
                    .background(Color.inputBackground)
                    .clipShape(Capsule())
                    .disabled(!(checkIfFilled(form: formInfo) && (formInfo.lastName != "")))
                }
                // Low friction has no checking if forms are filled
                else {
                    Button("Create Post") {
                        buttonClicked = 1
                    }
                    .padding()
                    .background(Color.inputBackground)
                    .clipShape(Capsule())
                }
                
                // Bottom of screen rectangle
                Rectangle()
                    .foregroundColor(.darkShadow)
                    .frame(width: sWidth, height: (150/896)*sHeight)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .ignoresSafeArea()
    }
}

// Displays computed "post" from given data from the form
struct DisplayView: View {
    var formInfo = FormSubmission()
    
    var body: some View {
        ZStack {
            // Background geometry
            Rectangle()
                .foregroundColor(.darkShadow)
                .frame(width: sWidth, height: (300/414)*sWidth)
                .cornerRadius((10/414)*sWidth)
            
            Rectangle()
                .foregroundColor(.lightShadow)
                .frame(width: sWidth-10, height: (300/414)*sWidth-10)
                .cornerRadius((10/414)*sWidth)
            
            // User input displayed as text
            VStack {
                Text("\(formInfo.firstName) \(formInfo.lastName)")
                    .font(.title).bold()
                Text(" \"\(formInfo.songName)\" ")
                Text(formInfo.genreName)
                    .foregroundColor(.darkShadow)
                Text("Song Length: \(formInfo.songLength, specifier: "%2.f") minutes")
                Text("Play")
                    .bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

// Checks if minimum info is filled out in the form -- name, song name, and song length
func checkIfFilled(form: FormSubmission) -> Bool {
    if (form.firstName + form.lastName != "") && (form.songName != "") && (form.songLength != 0) {
        return true
    }
    return false
}
