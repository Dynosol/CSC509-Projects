//
//  CardView.swift
//  Unit 5 Project
//
//  Created by Sol Kim on 12/9/21.
//

import SwiftUI

struct CardView: View {
    var properties: CardProperties
    
    @State var iconBools = [false, false, false]
    @State var stats = [0,0,0].map(numberGenerator)
//    @Binding var allCards: [CardProperties]
    @Binding var cardModel: CardModel
    
    let cardWidth = (93/100)*sWidth
    let cardHeight = (93/100)*sWidth*(0.6)
    // Favorited cards should have a blue line
    var cardOutlineColor: Color {
        properties.favorite ? .blue : .white
    }
    
    var body: some View {
        // Main body and background
        ZStack {
            // Background shape
            Rectangle()
                .frame(width: (95/100)*sWidth, height: (95/100)*sWidth*(0.6))
                .cornerRadius(sWidth*0.05)
                .foregroundColor(cardOutlineColor)
            Rectangle()
                .frame(width: (93/100)*sWidth, height: (93/100)*sWidth*(0.6))
                .cornerRadius(sWidth*0.04)
            
            // Innards within the card (everything but the background)
            VStack {
                HStack {
                    // Profile Picture
                    Image(String(properties.profPic))
                        .resizable()
                        .frame(width: cardHeight*(0.6), height: cardHeight*(0.6))
                    
                    // Description with artist title, song name, and song genre
                    VStack (alignment: .leading) {
                        Text(properties.name)
                            .foregroundColor(.white)
                            .font(.custom("", size: cardHeight*(0.1)))
                            .padding(.top, sWidth*(0.02))
                        
                        Text(properties.songName)
                            .foregroundColor(.white)
                        
                        Text(properties.genre)
                            .foregroundColor(.lightGrey)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    // "Preview Button" which increments number of plays and (in a finished app) would play a preview of the song
                    Button(action: {
                        stats[2] += 1
                        iconBools[2] = true
                    }, label: {
                        VStack {
                            Image("music solbookblue")
                                .resizable()
                                .frame(width: cardHeight*(0.3), height: cardHeight*(0.3))
                            Text("Preview")
                                .foregroundColor(.white)
                        }
                    }).padding(.trailing, sWidth*(0.03))

                }
                .frame(width: cardWidth*(0.9), height: cardHeight*(0.6))
                .padding(.top, cardWidth*(0.05))
                
                Spacer()
                
                // Likes, Follows, Listens
                HStack {
                    // Likes
                    SmallIcon(name: "heart.fill", stat: stats[0], index: 0, iconBool: $iconBools)
                        .padding(.leading, cardWidth*(0.1))
                    
                    Spacer()
                    
                    // Follows
                    SmallIcon(name: "person.fill", stat: stats[1], index: 1, iconBool: $iconBools)
                    
                    Spacer()
                    
                    // Listens
                    SmallIcon(name: "speaker.wave.2", stat: stats[2], listenIcon: true, index: 2, iconBool: $iconBools)
                        .padding(.trailing, cardWidth*(0.1))
                }
                .padding(.bottom, cardWidth*(0.05))
            }
            
            // Delete card button
            Button(action: {
                if cardModel.cards.count > 1 {
                    cardModel.cards.remove(at: properties.index)
                }
            }, label: {
                ZStack {
                    Circle()
                        .frame(width: cardHeight*(0.12), height: cardHeight*(0.12))
                        .foregroundColor(.black)
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: cardHeight*(0.12), height: cardHeight*(0.12))
                        .foregroundColor(.lightGrey)
                }
            }).offset(x: (-cardWidth/2)+(cardWidth*0.02), y: (-cardHeight/2)+(cardWidth*0.02))
        }
        .frame(width: (95/100)*sWidth, height: (95/100)*sWidth*(0.6))
    }
}

// Either the heart, person, or speaker icon along the bottom
struct SmallIcon: View {
    var name: String
    var stat: Int
    var listenIcon: Bool = false
    var index: Int
    
    // Learned about observable objects from:
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-observedobject-to-manage-state-from-external-objects
    @Binding var iconBool: [Bool]
    
    var iconColor: Color {
        iconBool[index] ? .blue : .white
    }
    
    let cardWidth = (93/100)*sWidth
    let cardHeight = (93/100)*sWidth*(0.6)
    
    var body: some View {
        HStack (spacing: 0) {
            Button(action: {
                iconBool[index].toggle()

                if listenIcon {iconBool[index] = true}
            }, label: {
                Image(systemName: name)
                    .resizable()
                    .frame(width: cardHeight*(0.15), height: cardHeight*(0.15))
                    .foregroundColor(iconColor)
                    .accessibilityLabel("Profile Picture")
            })
            
            Text(String(stat))
                .foregroundColor(.white)
                .frame(width: cardWidth*(0.2), height: cardHeight*(0.1))
        }
    }
}

// Learned function without referring to parameters from:
// https://docs.swift.org/swift-book/LanguageGuide/Functions.html
// Learned random generator from:
// https://www.hackingwithswift.com/articles/102/how-to-generate-random-numbers-in-swift
let numberGenerator = { (_: Int) -> Int in
    Int.random(in: 1..<100000)
}

// Card Properties object that holds all the different aspects of a card
struct CardProperties: Identifiable {
    var id = UUID()
    var index: Int
    
    var profPic: Int
    var name: String
    var songName: String
    var genre: String
    var favorite: Bool
}
