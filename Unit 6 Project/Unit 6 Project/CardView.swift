//
//  CardView.swift
//  Unit 6 Project
//
//  Created by Sol Kim on 1/19/22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

// Type of model layer based on:
// https://www.hackingwithswift.com/forums/swiftui/foreach-with-array-binding-crash-on-item-deletion/7394
// Learned identifiable from:
// https://www.hackingwithswift.com/books/ios-swiftui/working-with-identifiable-items-in-swiftui
struct Card: Identifiable, Codable, Hashable, Equatable {
    @DocumentID var id = UUID().uuidString
    var title: String
    var desc: String
    var highval: Bool
    var completed: Bool
    
    // Learned from:
    // https://developer.apple.com/documentation/swift/equatable
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.title == rhs.title && lhs.desc == rhs.desc && lhs.highval == rhs.highval && lhs.completed == rhs.completed
    }
}

struct CardView: View {
    @ObservedObject var playerModel: PlayerModel
    
    var index: Int
    var cardWidth = sWidth*(0.9)
    var cardHeight = sHeight*(0.1)
    
    var body: some View {
        
        if index < playerModel.cards.count {
            VStack {
                NavigationLink(destination: CardDetail(playerModel: playerModel, index: index),
                    label: {
                        ZStack {
                            // Background rectangle
                            // Outline
                            Rectangle()
                                .foregroundColor(playerModel.cards[index].highval ? Color.red : Color.white)
                                .frame(width: cardWidth*(1.02), height: cardHeight*(1.05))
                                .cornerRadius(sWidth*(0.05))
                            
                            Rectangle()
                                .foregroundColor(!playerModel.cards[index].completed ? colorinator(carray: playerModel.myColor) : Color.darkTan)
                                .frame(width: cardWidth, height: cardHeight)
                                .cornerRadius(sWidth*(0.05))
                            
                            // Body text
                            HStack {
                                VStack (spacing: sHeight*(0.01)){
                                    Text(playerModel.cards[index].title)
                                        // Card title should be black if not completed
                                        .foregroundColor(Color.black)
                                        .font(.custom("", size: sWidth*(0.06)))
                                    
                                    Text(playerModel.cards[index].desc)
                                        .font(.custom("", size: sWidth*(0.04)))
                                        .foregroundColor(.darkGray)
                                }.frame(width: sWidth*(0.7), height: sHeight*(0.1))
                                
                                // Toggle button
                                DoneButton(playerModel: playerModel, index: index, text: "Done")
                            }
                            
                            // Delete card button
                            Button(action: {
                                // https://stackoverflow.com/questions/24051633/how-to-remove-an-element-from-an-array-in-swift
                                playerModel.cards.remove(at: index)
                            }, label: {
                                ZStack {
                                    Circle()
                                        .frame(width: cardHeight*(0.25), height: cardHeight*(0.25))
                                        .foregroundColor(.black)
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: cardHeight*(0.25), height: cardHeight*(0.25))
                                        .foregroundColor(.gray)
                                }
                            }).offset(x: (-cardWidth/2)+(cardWidth*0.05), y: (-cardHeight/2)+(cardWidth*0.05))
                        }
                    })
            }
        .background(Color.backgroundColor)
        }
    }
}

// Done button on every todo card; toggles the completed value of each todo
struct DoneButton: View {
    @ObservedObject var playerModel: PlayerModel
    var index: Int
    var text: String
    
    var body: some View {
        if index < playerModel.cards.count {
            Button(action: {
                playerModel.cards[index].completed.toggle()
            }, label: {
                Text(text)
                    .foregroundColor(.white)
                    .padding(sWidth*(0.01))
                    .background(!playerModel.cards[index].completed ? Color.blue : Color.gray)
                    .clipShape(Capsule())
            })
        }
    }
}
