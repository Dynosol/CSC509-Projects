//
//  ContentView.swift
//  Unit 5 Project
//
//  Created by Sol Kim on 12/9/21.
//

// Citations
//1) AI Generated faces from: https://generated.photos/
//2) https://docs.swift.org/swift-book/LanguageGuide/Functions.html
//3) https://www.hackingwithswift.com/articles/102/how-to-generate-random-numbers-in-swift
//4) https://stackoverflow.com/questions/58516229/how-to-add-a-new-swiftui-color
//5) https://stackoverflow.com/questions/36325676/how-to-append-object-multiple-time-to-an-array
//6) https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-observedobject-to-manage-state-from-external-objects
//7) https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
//8) https://thehappyprogrammer.com/custom-textfield-in-swiftui/
//9) https://developer.apple.com/documentation/swift/array/2994747-randomelement
//10) https://www.hackingwithswift.com/articles/102/how-to-generate-random-numbers-in-swift
//11) https://developer.apple.com/documentation/swiftui/textfield
//12) https://www.agnosticdev.com/content/how-get-first-or-last-characters-string-swift-4
//13) https://developer.apple.com/documentation/swiftui/stateobject
//14) https://medium.com/@sajalgupta4me/cannot-assign-to-value-is-a-let-constant-swift-1a55d829f5b2
//15) https://developer.apple.com/forums/thread/132452

import SwiftUI

// Width and height global constants used for scaling sizes
let sWidth = UIScreen.main.bounds.width
let sHeight = UIScreen.main.bounds.height

// Global custom color variables
// Once again, learned color extension from:
// https://stackoverflow.com/questions/58516229/how-to-add-a-new-swiftui-color
extension Color {
    static let bgGrey = Color(red: 30/255, green: 30/255, blue: 30/255)
    static let lightGrey = Color(red: 210/255, green: 210/255, blue: 210/255)
    static let inputBackground = Color(red: 214/255, green: 214/255, blue: 214/255)
}

struct ContentView: View {
//    @State var cards: [CardProperties] = []
    @State var cardModel = CardModel(cards: [])
    
    var body: some View {
        TabView {
//            HomeScreen(cards: $cards)
            HomeScreen(cardModel: $cardModel)
                .tabItem {
                    Image(systemName: "music.note.house")
                    Text("Home")
                }
            
            TrendingScreen()
                .tabItem {
                    Image(systemName: "flame")
                    Text("Trending")
                }
            
            SettingsScreen()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

// In a completed app, this would show trending songs
struct TrendingScreen: View {
    var body: some View {
        Text("In a completed app, this would show trending songs")
    }
}

// In a completed app, this would be the settings screen
struct SettingsScreen: View {
    var body: some View {
        Text("In a completed app, this would be the settings screen")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class CardModel {
    var cards: [CardProperties]
    
    init(cards: [CardProperties]) {
        self.cards = cards
    }
    
}
