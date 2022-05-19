//
//  ContentView.swift
//  Unit 4 Project
//
//  Created by Sol Kim on 11/8/21.
//

// Sources Cited:
//1) DRIBBLE LINK: https://dribbble.com/shots/16810017-Smart-Home-App-Ui-Design
//2) https://stackoverflow.com/questions/68697255/how-to-set-the-opacity-of-an-overlay-in-swiftui
//3) https://www.hackingwithswift.com/quick-start/swiftui/how-to-adjust-the-way-an-image-is-fitted-to-its-space
//4) https://stackoverflow.com/questions/57342170/how-do-i-set-the-size-of-a-sf-symbol-in-swiftui
//5) https://www.hackingwithswift.com/sixty/5/5/omitting-parameter-labels

import SwiftUI

// constants used for scaling
let sWidth = UIScreen.main.bounds.width
let sHeight = UIScreen.main.bounds.height

// Defining global custom colors
extension Color {
    static let togglePurple = Color(red: 114/255, green: 83/255, blue: 251/255)
    static let lightBlue = Color(red: 186/255, green: 208/255, blue: 1)
    static let lime = Color(red: 226/255, green: 241/255, blue: 205/255)
    static let lightBulbRed = Color(red: 196/255, green: 17/255, blue: 0)
    static let brightGreen = Color(red: 0, green: 1, blue: 81/255)
    static let niceBlue = Color(red: 139/255, green: 201/255, blue: 194/255)
    static let lightGrey = Color(red: 200/255, green: 200/255, blue: 200/255)
}

struct ContentView: View {
    var body: some View {
        TabView {
            GivenDesign()
                .tabItem {
                    Image(systemName: "person.fill.questionmark")
                    Text("Example Design")
                }
            
            ImprovedDesign()
                .tabItem {
                    Image(systemName: "person.fill.checkmark")
                    Text("Improved Design")
                }
        }
    }
}

// Scales size values from how it looks on iPhone11 to other devices
// Learned how to omit function parameter labels from:
// https://www.hackingwithswift.com/sixty/5/5/omitting-parameter-labels
func scale(_ value: Int) -> CGFloat {
    return CGFloat((Double(value)/Double(414)))*sWidth
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
