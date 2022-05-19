//
//  HomeScreen.swift
//  Unit 5 Project
//
//  Created by Sol Kim on 12/10/21.
//

import SwiftUI

struct HomeScreen: View {
    // List of first names, last names, song genres, and song names to be put in the posts
    let firstNames = ["Alex", "Daniel", "Sam", "Sol", "Tim", "Thomas", "Jason", "Justin", "Tanner", "Liam", "Noah", "Sarah", "Kate", "Alexandra", "Taylor", "Emily", "Emma", "Olivia", "Anna", "Ava", "John", "Isabella", "Seb", "Chase", "Andrew", "Ethan", "Bennett", "Jack"]

    let lastNames = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Wilson", "Anderson", "Lee", "White", "Altomare", "Reynders", "Kim", "Kington", "Elliot", "Zufelt", "Dorsey", "Park", "Li", "Hurston"]

    let genres = ["Rock", "Funk Rock", "Alt Rock", "Punk Rock", "Heavy Metal", "Alt Pop", "Alternative Music", "Country", "Jazz", "Bebop", "Jazz Fusion", "Hip Hop", "R&B", "Rap", "Folk", "Soul", "Classical", "Electronic", "Reggae", "Gospel", "EDM", "Funk", "Disco", "Instrumental", "Techno", "Bluegrass", "Swing", "Ambient", "Trance", "Indie Rock", "Dubstep", "Grunge", "New Wave", "Psychedelic"]

    let songNames = ["Uptown Funk!", "Party Rock Anthem", "Shape of You", "Closer", "Girls Like You", "We Found Love", "Old Town Road", "Somebody That I Used To Know", "Despacito", "Rolling In The Deep", "Sunflower", "Without Me", "Call Me Maybe", "Blurred Lines", "Perfect", "Sicko Mode", "All About That Bass", "Royals", "God's Plan", "Moves Like Jagger", "Happy", "Just The Way You Are", "Rockstar", "TiK ToK", "See You Again", "Dark Horse", "Thrift Shop", "One More Night", "We Are Young", "That's What I Like", "The Hills", "All Of Me", "Happier", "Shake It Off", "One Dance", "Radioactive", "Sexy And I Know It", "Someone Like You", "Counting Stars", "E.T", "Trap Queen", "Love Yourself", "Firework", "Give Me Everything", "Locked Out Of Heaven", "Love The Way You Lie", "Thinking Out Loud", "Sorry", "California Gurls", "Dynamite"]
    
    @State var showFavorite: Bool = false
//    @Binding var cards: [CardProperties]
    @Binding var cardModel: CardModel
    
    // Filter that creates array of favorite cards
    var favoriteCards: [CardProperties] {
        cardModel.cards.filter {
            showFavorite ? $0.favorite : false
        }
    }
    
    // This function adds a new card every time you load the page, acting different people are uploading
    // Learned inout from:
    // https://medium.com/@sajalgupta4me/cannot-assign-to-value-is-a-let-constant-swift-1a55d829f5b2
//    func appendToCards(cards: inout [CardProperties]) -> Void {
    func appendToCards(cards: [CardProperties]) -> Void {
        // Learned random element from:
        // https://developer.apple.com/documentation/swift/array/2994747-randomelement
        // Learned bool random from:
        // https://developer.apple.com/documentation/swift/bool/2994861-random
        cardModel.cards.append(
            CardProperties(index: cardModel.cards.count, profPic: Int.random(in: 2..<22), name: "\(firstNames.randomElement()!) \(lastNames.randomElement()!)", songName: "'\(songNames.randomElement()!)'", genre: "\(genres.randomElement()!)", favorite: Bool.random())
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Title bar
                ZStack {
                    Color.lightGrey
                        .edgesIgnoringSafeArea(.all)
                    
                    // Create card button
                    HStack {
                        Spacer()
                        VStack {
                            NavigationLink(destination: CreateCard(cardModel: $cardModel), label: {
                                Image(systemName: "plus.square")
                                    .resizable()
                                    .frame(width: sWidth*(0.08), height: sWidth*(0.08))
                                })
                            .padding()
                            Spacer()
                        }
                    }
                    
                    // Title text
                    VStack {
                        Text("SolBook")
                            .font(.custom("", size: sHeight*(0.04)).bold())
                        
                        // Filter by liked only option
                        Toggle(isOn: $showFavorite, label: {
                            HStack {
                                Image(systemName: "heart.square.fill")
                                Text("View favorites only")
                            }
                        })
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                        .padding(.horizontal, sWidth*(0.2))
                    }
                }.frame(width: sWidth, height: sHeight*(0.14))
                
                // Scrollview of the different cards
                // Embed vstack within scrollview to set boundaries of scrollview trick learned from:
                // https://developer.apple.com/forums/thread/132452
                ScrollView {
                    VStack {
                        // Only show favorited cards if toggled on
                        if showFavorite {
                            ForEach(favoriteCards) { card in
                                CardView(properties: card, cardModel: $cardModel)
                            }
                        }
                        
                        // If no filter is on
                        else {
                            ForEach(cardModel.cards) { card in
                                CardView(properties: card, cardModel: $cardModel)
                            }
                        }
                    }.frame(width: sWidth, height: sHeight*(0.80), alignment: .top)
                }
            }
            // onappear simulating other people uploading stuff
            .onAppear{
                appendToCards(cards: cardModel.cards)
                }
            .background(Color.bgGrey)
            .navigationBarHidden(true)
        }
    }
}
