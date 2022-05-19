//
//  ShopScreen.swift
//  Unit 6 Project
//
//  Created by Sol Kim on 1/20/22.
//

import SwiftUI

struct ShopItem: Codable, Equatable {
    var name: String
    var cost: Int
    var desc: String = ""
    // Because Color is not a codable type
    var red: Int = 255
    var green: Int = 255
    var blue: Int = 255
    var bought: Bool = false
}

// random descriptions for shop items in scrollview
let randomDescs = ["You really want this.",
                   "This is super cool!",
                   "You sure you want this?",
                   "Make sure you have enough!",
                   "Personally, I don't think it's that cool.",
                   "My favorite!",
                   "You will be a legend with this.",
                   "Why get this?",
                   "Wayyy to expensive!",
                   "A little cheap, don't you think?",
                   "I wouldn't get it",
                   "YOU HAVE TO GET THIS RIGHT NOW!!!",
                   "Dr. Zufelt Approved (TM)",
                   "Don't buy this",
                   "Critically Acclaimed",
                   "Rated 0.9 stars out of 5",
                   "Rated 4.8 stars out of 5",
                   "How did this get here?"]

struct ShopScreen: View {
    @ObservedObject var playerModel: PlayerModel
    
    var body: some View {
        VStack {
            TitleBar(playerModel: playerModel)
            
            ScrollView {
                ForEach(0..<playerModel.inv.count, id: \.self) {i in
                    ItemView(playerModel: playerModel, index: i)
                }
            }
        }
        .background(Color.backgroundColor)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

// View for each item in the shop
struct ItemView: View {
    @ObservedObject var playerModel: PlayerModel
    @State var showingAlert = false
    
    var index: Int
    var cardWidth = sWidth*(0.9)
    var cardHeight = sHeight*(0.2)
    
    // user needs enough money to buy things
    func verifyBuyable(model: PlayerModel, item: ShopItem) -> Bool {
        if model.coins >= item.cost && !item.bought {return true}
        return false
    }
    
    var body: some View {
        // Checks if user can buy the item, then it is toggled to be bought
        Button {
            if verifyBuyable(model: playerModel, item: playerModel.inv[index]) {
                playerModel.coins -= playerModel.inv[index].cost
                playerModel.inv[index].bought = true
            }
        } label: {
            ZStack {
                // Background outline should be gray if bought
                Rectangle()
                    .foregroundColor(!playerModel.inv[index].bought ? colorinator(carray: playerModel.myColor) : .gray)
                    .frame(width: cardWidth, height: cardHeight)
                    .cornerRadius(sWidth*(0.02))
                // Card body should be gray if bought too
                Rectangle()
                    .foregroundColor(playerModel.inv[index].bought ? .gray : Color(red: Double(CGFloat(playerModel.inv[index].red))/255, green: Double(CGFloat(playerModel.inv[index].green))/255, blue: Double(CGFloat(playerModel.inv[index].blue))/255))
                    .frame(width: cardWidth*(0.97), height: cardHeight*(0.95))
                    .cornerRadius(sWidth*(0.02))
                
                // Body text of a shop item
                HStack {
                    VStack (spacing: sHeight*(0.01)){
                        Text(playerModel.inv[index].name)
                            .font(.custom("", size: cardHeight*(0.2))).bold()
                            .foregroundColor(.black)
                        
                        Text(String(randomDescs.randomElement()!))
                            .font(.custom("", size: sWidth*(0.04)))
                            .foregroundColor(.darkGray)
                            // https://developer.apple.com/documentation/swiftui/text/multilinetextalignment(_:)
                            .multilineTextAlignment(.center)
                        
                        Text("Cost: \(playerModel.inv[index].cost)")
                            .foregroundColor(.black)
                    }.frame(width: cardWidth*(0.8), height: cardHeight)
                }
            }
        }
    }
}
