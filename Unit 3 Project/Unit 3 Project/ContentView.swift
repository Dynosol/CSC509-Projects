//
//  ContentView.swift
//  Unit 3 Project
//
//  Created by Sol Kim on 10/25/21.
//

// Sources Cited:
//1) https://developer.apple.com/documentation/swiftui/textfield
//2) https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
//3) https://thehappyprogrammer.com/custom-textfield-in-swiftui/
//4) https://www.simpleswiftguide.com/swiftui-slider-tutorial-how-to-create-and-use-slider-in-swiftui/
//5) https://www.appcoda.com/swiftui-toggle-style/
//6) https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-an-alert
//7) https://stackoverflow.com/questions/57130866/how-to-show-navigationlink-as-a-button-in-swiftui

import SwiftUI

// Defining global custom colors
// Code based on: https://thehappyprogrammer.com/custom-textfield-in-swiftui/
extension Color {
    static let background = Color(red: 190/255, green: 190/255, blue: 190/255)
    static let inputBackground = Color(red: 214/255, green: 214/255, blue: 214/255)
    static let darkShadow = Color(red: 140/255, green: 140/255, blue: 140/255)
    static let lightShadow = Color(red: 240/255, green: 240/255, blue: 240/255)
    static let textColor = Color.black
    static let turquoise = Color(red: 34/255, green: 186/255, blue: 148/255)
}

// Screen size constants used for scaling views
let sWidth = UIScreen.main.bounds.width
let sHeight = UIScreen.main.bounds.height

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                LowFriction()
                    .tabItem {
                        Image(systemName: "person.fill.questionmark")
                        Text("Low Friction")
                    }
                MedFriction()
                    .tabItem {
                        Image(systemName: "person.fill.checkmark")
                        Text("Right Friction")
                    }
                HighFriction()
                    .tabItem {
                        Image(systemName: "person.fill.xmark")
                        Text("High Friction")
                    }
            }
        }
    }
}

// Neumorphic Style from:
// https://thehappyprogrammer.com/custom-textfield-in-swiftui/
struct NeumorphicStyleTextField: View {
    var textField: TextField<Text>
        var body: some View {
            textField
            .padding()
            .foregroundColor(.textColor)
            .background(Color.inputBackground)
            .cornerRadius((6/896)*sHeight)
            .shadow(color: Color.darkShadow, radius: (3/896)*sHeight, x: (2/896)*sHeight, y: (2/896)*sHeight)
            .shadow(color: Color.lightShadow, radius: (3/896)*sHeight, x: (-2/896)*sHeight, y: (-2/896)*sHeight)
            
        }
}

// Neumorphic Style Text Input Box
struct TextInput: View {
    var text: String
    var variable: Binding<String>
    
    var body: some View {
        // TextField learned from:
        // https://developer.apple.com/documentation/swiftui/textfield
        NeumorphicStyleTextField(textField: TextField(text, text: variable))
            .disableAutocorrection(true)
            .padding(.horizontal, (10/896)*sHeight)
    }
}

// Nice looking text that isn't input box
struct InfoTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding((10/896)*sHeight)
            .background(Color.inputBackground)
            .cornerRadius((6/896)*sHeight)
            .shadow(color: Color.darkShadow, radius: (3/896)*sHeight, x: (2/896)*sHeight, y: (2/896)*sHeight)
            .shadow(color: Color.lightShadow, radius: (3/896)*sHeight, x: (-2/896)*sHeight, y: (-2/896)*sHeight)
            .padding((10/896)*sHeight)
    }
}

// Styling for yes/no toggle butotons
struct ToggleButton: View {
    var text: String
    var variable: Binding<Bool>
    
    var body: some View {
        // Toggle styling learned from:
        // https://www.appcoda.com/swiftui-toggle-style/
        Toggle(isOn: variable, label: {
            Text(text)
        })
        .padding(.horizontal, (10/896)*sHeight)
        .toggleStyle(SwitchToggleStyle(tint: .turquoise))
    }
}

// Code based on:
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
// Form input data object that gets passed from view to view
class FormSubmission: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var songName = ""
    @Published var genreName = ""
    @Published var genreIndex = 0
    @Published var songLength = 0.00
    
    @Published var makeSongPublic = false
    @Published var makeSongShareable = false
    @Published var makeSongFriendsOnly = false
    @Published var makeSongUnlisted = false
    
    @Published var allowUserInteraction = false
    @Published var allowLiking = false
    @Published var allowFollow = false
    @Published var allowPreview = false
    
    @Published var allowSolbook = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
