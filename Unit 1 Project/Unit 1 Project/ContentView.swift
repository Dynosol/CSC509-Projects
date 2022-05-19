//
//  ContentView.swift
//  Unit 1 Project - SolBook - Music Artist and Genre Finder
//
//  Created by Sol Kim on 9/21/21.
//

// iPhone 11 width -- 414 pixels

/*
 Sources Cited:
 https://developer.apple.com/documentation/swiftui/spacer
 https://www.hackingwithswift.com/sixty/4/1/for-loops
 https://generated.photos/
 https://developer.apple.com/documentation/swift/array/2994747-randomelement
 https://www.hackingwithswift.com/articles/102/how-to-generate-random-numbers-in-swift
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-gradient
 */

import SwiftUI

// Setting up colors used in the programs
let background_grey = Color(red: 94/255, green: 94/255, blue: 94/255)
let SolBookBlue = Color(red: 19/255, green: 85/255, blue: 191/255)
let mygrey = Color(red: 60/255, green: 60/255, blue: 60/255)
let lightgrey = Color(red: 227/255, green: 227/255, blue: 227/255)

// Sets number of randomly generated "posts"
let NUMBER_OF_POSTS = 100

// List of first names, last names, song genres, and song names to be put in the posts
let firstNames = ["Alex", "Daniel", "Sam", "Sol", "Tim", "Thomas", "Jason", "Justin", "Tanner", "Liam", "Noah", "Sarah", "Kate", "Alexandra", "Taylor", "Emily", "Emma", "Olivia", "Anna", "Ava", "John", "Isabella", "Seb", "Chase", "Andrew", "Ethan", "Bennett", "Jack"]

let lastNames = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Wilson", "Anderson", "Lee", "White", "Altomare", "Reynders", "Kim", "Kington", "Elliot", "Zufelt", "Dorsey", "Park", "Li", "Hurston"]

let genres = ["Rock", "Funk Rock", "Alt Rock", "Punk Rock", "Heavy Metal", "Alt Pop", "Alternative Music", "Country", "Jazz", "Bebop", "Jazz Fusion", "Hip Hop", "R&B", "Rap", "Folk", "Soul", "Classical", "Electronic", "Reggae", "Gospel", "EDM", "Funk", "Disco", "Instrumental", "Techno", "Bluegrass", "Swing", "Ambient", "Trance", "Indie Rock", "Dubstep", "Grunge", "New Wave", "Psychedelic"]

let songNames = ["Uptown Funk!", "Party Rock Anthem", "Shape of You", "Closer", "Girls Like You", "We Found Love", "Old Town Road", "Somebody That I Used To Know", "Despacito", "Rolling In The Deep", "Sunflower", "Without Me", "Call Me Maybe", "Blurred Lines", "Perfect", "Sicko Mode", "All About That Bass", "Royals", "God's Plan", "Moves Like Jagger", "Happy", "Just The Way You Are", "Rockstar", "TiK ToK", "See You Again", "Dark Horse", "Thrift Shop", "One More Night", "We Are Young", "That's What I Like", "The Hills", "All Of Me", "Happier", "Shake It Off", "One Dance", "Radioactive", "Sexy And I Know It", "Someone Like You", "Counting Stars", "E.T", "Trap Queen", "Love Yourself", "Firework", "Give Me Everything", "Locked Out Of Heaven", "Love The Way You Lie", "Thinking Out Loud", "Sorry", "California Gurls", "Dynamite"]

// Sizes for various elements
let topBarHeight = photoSize
let bottomBarHeight = UIScreen.main.bounds.width/5.175

let chatIconSize = UIScreen.main.bounds.width/8.28
let dividerHeight = UIScreen.main.bounds.width/207

let photoSize = UIScreen.main.bounds.width/4.14
let iconSize = UIScreen.main.bounds.width/13.8
let smallIconSize = UIScreen.main.bounds.width/10.35

let smallFontSize = UIScreen.main.bounds.width/20.7

let titleFontSize = UIScreen.main.bounds.width/11.5

struct ContentView: View {
    var body: some View {
        // Overall VStack
        VStack(spacing: 0){
            TopMenuBarView()
            
            // Grey divider line
            GreyDividerlineView()
            
            // Center-of-screen feed
            ScrollView{
                VStack(spacing: photoSize/10){
                    
                    // Learned how to create a for loop from:
                    // https://www.hackingwithswift.com/sixty/4/1/for-loops
                    ForEach(0..<NUMBER_OF_POSTS) {_ in
                        ZStack{
                            VStack(spacing: photoSize/10){
                                
                                // Picture, name, genre, song name, preview
                                HStack{
                                    // Profile Picture
                                    // Photo from Generated Photos https://generated.photos/
                                    RandomImageView()
                                    
                                    // Artist and song information
                                    VStack{
                                        // Learned random element selection from array from:
                                        // https://developer.apple.com/documentation/swift/array/2994747-randomelement
                                        MyTextView(text: "\(firstNames.randomElement()!) \(lastNames.randomElement()!)", fontSize: smallFontSize, height: UIScreen.main.bounds.width/17.25)
                                        
                                        MyTextView(text: "\(genres.randomElement()!)", fontSize: UIScreen.main.bounds.width/23, height: smallFontSize, fontColor: .gray)

                                        MyTextView(text: "'\(songNames.randomElement()!)'", fontSize: UIScreen.main.bounds.width/25.88, height: smallFontSize)
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                    
                                    // Preview button
                                    PreviewButtonView()
                                }.frame(width: UIScreen.main.bounds.width/1.183, height: photoSize)
                                
                                // Likes, listens, followers
                                HStack{
                                    Spacer()
                                    // Learned about random number generation from:
                                    // https://www.hackingwithswift.com/articles/102/how-to-generate-random-numbers-in-swift
                                    SimpleIconView(imageName: "heart", startInt: 1, endInt: 100000)
                                    
                                    // Listens icon
                                    SimpleIconView(imageName: "music", startInt: 10000, endInt: 500000)
                                    
                                    // Followers icon
                                    SimpleIconView(imageName: "user", startInt: 1000, endInt: 10000)
                                }
                            }
                        }.foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(width: smallIconSize*10, height: smallFontSize*10)
                        .background(
                                // Learned how to make a linear gradient from:
                                // https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-gradient
                                LinearGradient(gradient: Gradient(colors: [mygrey, .black]), startPoint: .top, endPoint: .bottom)
                            )
                            .cornerRadius(smallFontSize)
                            .padding(photoSize/100)
                            .background(Color.white)
                            .cornerRadius(smallFontSize)
                    }
                }
            }
            .background(Color.black)
            
            // Grey divider line
            GreyDividerlineView()
            
            // Bottom-of-screen menu bar
            HStack{
                // Home Button
                BottomIconView(imageName: "home", size: smallIconSize, verticalPadding: photoSize/10, horizontalPadding: UIScreen.main.bounds.width/16.56)
                
                // Search/Explore Button
                BottomIconView(imageName: "search", size: smallIconSize, verticalPadding: photoSize/10, horizontalPadding: UIScreen.main.bounds.width/16.56)
                
                // Personal Button
                BottomIconView(imageName: "user", size: smallIconSize, verticalPadding: photoSize/10, horizontalPadding: UIScreen.main.bounds.width/16.56)
                
                //Settings button
                BottomIconView(imageName: "settings", size: smallIconSize, verticalPadding: photoSize/10, horizontalPadding: UIScreen.main.bounds.width/16.56)
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: bottomBarHeight)
            .background(SolBookBlue)
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

struct TopMenuBarView: View {
    var body: some View {
        HStack{
            // Title text
            VStack {
                // Learned about Spacer from:
                // https://developer.apple.com/documentation/swiftui/spacer
                Spacer()
                Text("SolBook")
                    .font(.custom("arial", size: titleFontSize))
                    .foregroundColor(.white)
                    .padding()
            }
            Spacer()
            // Chat Button
            VStack{
                Spacer()
                Image("chat")
                    .resizable()
                    .frame(width: chatIconSize, height: chatIconSize)
                    .padding()
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: topBarHeight)
        .background(SolBookBlue)
    }
}

struct BottomIconView: View {
    var imageName: String
    var size: CGFloat
    var verticalPadding: CGFloat
    var horizontalPadding: CGFloat
    
    var body: some View {
        Image(self.imageName)
            .resizable()
            .frame(width: self.size, height: self.size)
            .padding(.vertical, self.verticalPadding)
            .padding(.horizontal, self.horizontalPadding)
    }
}

struct SimpleIconView: View {
    var imageName: String
    var startInt: Int
    var endInt: Int
    
    var body: some View {
        Image(self.imageName)
            .resizable()
            .frame(width: iconSize, height: iconSize)
        
        Text("\(Int.random(in: self.startInt..<self.endInt))")
            .font(.custom("", size: smallFontSize))
        
        Spacer()
    }
}

struct PreviewButtonView: View {
    var body: some View {
        VStack(spacing: 0){
            
            Text("  Preview")
                .font(.custom("none", size: UIScreen.main.bounds.width/29.57))
            
            // Preview icon
            Image("music solbookblue")
                .resizable()
                .frame(width: UIScreen.main.bounds.width/6.9, height: UIScreen.main.bounds.width/6.9)
        }
    }
}

struct GreyDividerlineView: View {
    var body: some View {
        Rectangle()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: dividerHeight)
            .foregroundColor(lightgrey)
    }
}

struct MyTextView: View {
    var text: String
    var fontSize: CGFloat
    var height: CGFloat
    var fontColor: Color = .white
    
    var body: some View {
        Text(self.text)
            .font(.custom("none", size: self.fontSize))
            .foregroundColor(self.fontColor)
            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: self.height, alignment: .topLeading)
    }
}

struct RandomImageView: View {
    var body: some View {
        Image("\(Int.random(in: 2..<22))")
            .resizable()
            .frame(width: photoSize, height: photoSize)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
