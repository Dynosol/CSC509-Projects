//
//  HomeScreen.swift
//  Unit 6 Project
//
//  Created by Sol Kim on 1/18/22.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var playerModel: PlayerModel
    
    var body: some View {
        VStack {
            // Titlebar and coins view
            TitleBar(playerModel: playerModel)
            
            HStack (spacing: 0){
                Text("YOUR TODOS")
                    .foregroundColor(.black)
                    .font(.custom("", size: sHeight*(0.03)))

                NavigationLink(destination: CardCreation(playerModel: playerModel)
                    // Learned to remove bar from:
                    // https://www.hackingwithswift.com/forums/swiftui/removing-unwanted-and-unknown-whitespace-possibly-a-navigation-bar-above-a-view/7343
                    .navigationBarBackButtonHidden(false),
                    label: {
                        Image(systemName: "plus.square")
                            .resizable()
                            .frame(width: sWidth*(0.08), height: sWidth*(0.08))
                    }
                ).padding()
                
                // Learned removeall from:
                // https://www.hackingwithswift.com/example-code/language/removing-matching-elements-from-a-collection-removeallwhere
                // Clear completed tasks and add coins!
                Button(action: {
                    var completedCount = 0
                    
                    playerModel.cards.forEach { if $0.completed {completedCount += 1}}
                    playerModel.cards.forEach { if $0.highval && $0.completed {completedCount += 1}}
                    playerModel.coins += (completedCount * 100)
                    
                    playerModel.cards.removeAll(where: { $0.completed })
                    
                    completedCount = 0
                }){
                    Text("Cash In")
                        .font(.custom("", size: sWidth*0.04))
                        .multilineTextAlignment(.center)
                }
                
            }.frame(height: sHeight*(0.06))
            
            // Scroll of all of the TODOs
            ScrollView {
                ForEach(0..<playerModel.cards.count, id: \.self) {i in
                    CardView(playerModel: playerModel, index: i)
                }
            }
        }
        .background(Color.backgroundColor)
    }
}

// Titlebar that is on top of every "main" view: says DynoTODO and shows coins
struct TitleBar: View {
    @ObservedObject var playerModel: PlayerModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(colorinator(carray: playerModel.myColor))
                .frame(width: sWidth, height: sHeight*(0.13))
            
            HStack {
                Text("DynoTODO")
                    .font(.custom("", size: sHeight*(0.05)))
                    .padding(.leading, sWidth*(0.03))
                
                Image(systemName: "bitcoinsign.circle")
                    .font(.custom("", size: sHeight*(0.03)))
                    .padding(.leading, sWidth*(0.1))
                
                Text(String(playerModel.coins))
            }
            .padding(.top, sHeight*(0.03))
        }.ignoresSafeArea()
    }
}
