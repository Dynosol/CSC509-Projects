//
//  InventoryScreen.swift
//  Unit 6 Project
//
//  Created by Sol Kim on 1/20/22.
//

import SwiftUI

struct InventoryScreen: View {
    @ObservedObject var playerModel: PlayerModel
    
    var body: some View {
        VStack {
            TitleBar(playerModel: playerModel)
            
            List {
                let boughted = playerModel.inv.filter{$0.bought}
                
                ForEach(0..<boughted.count, id: \.self) {i in
                    // Learned prefix from:
                    // https://stackoverflow.com/questions/39677330/how-does-string-substring-work-in-swift
                    // If color is clicked in inventory, make that the main color
                    if boughted[i].name.prefix(5) == "Color" {
                        ColorItem(playerModel: playerModel, index: i)
                    } else {
                        // If the item is not a color, link to the itemview page
                        NavigationLink(destination: ItemDetail(playerModel: playerModel, index: i)) {
                            HStack {
                                Text(boughted[i].name)
                                Spacer()
                                Text("view")
                            }
                        }
                    }
                }
            }
        }
        .background(Color.backgroundColor)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct ColorItem: View {
    @ObservedObject var playerModel: PlayerModel
    var index: Int
    
    var body: some View {
        let boughted = playerModel.inv.filter{$0.bought}
        
        Button {
            playerModel.myColor = [
                boughted[index].red,
                boughted[index].green,
                boughted[index].blue
            ]
        } label: {
            if index < boughted.count {
                HStack {
                    // Color item should show "use" text
                    Text(boughted[index].name)
                    Spacer()
                    Text("use")
                        .foregroundColor(.blue)
                }
            }
        }

    }
}

struct ItemDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var playerModel: PlayerModel
    var index: Int
    
    var body: some View {
        let boughted = playerModel.inv.filter{$0.bought}[index]
        
        Text("\(boughted.name)")
            .font(.custom("", size: sHeight*(0.1)))
            .padding(.top, sHeight*(0.05))
        
        Image("\(boughted.name)")
            .resizable()
            .frame(width: sWidth*(0.6), height: sWidth*(0.6))
            .background(Color.backgroundColor)
        
        Spacer()
        
        Text("'\(boughted.desc)'")
            .padding(.bottom, sHeight*(0.05))
    }
}
