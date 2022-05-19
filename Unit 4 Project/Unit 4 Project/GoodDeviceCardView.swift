//
//  GoodDeviceCardView.swift
//  Unit 4 Project
//
//  Created by Sol Kim on 11/9/21.
//

import SwiftUI

// Images used in each device in order
let imagesOrder = ["wind.snow", "lightbulb", "speaker.wave.3", "tv"]

// How each "improved" card looks
struct GoodDeviceCardView: View {
    var index: Int
    var title: String
    var color: Color
    
    @Binding var isOn: [Bool]
    @Binding var temperature: Int
    
    var body: some View {
        ZStack {
            // Background rectangle
            Rectangle()
                .frame(width: 0.9*sWidth, height: index != 0 ? sHeight/8 : sHeight/5)
                .foregroundColor(color)
                .cornerRadius(0.03*sWidth)
                .padding(0.01*sWidth)
                .opacity(isOn[index] ? 1 : 0.6)
            
            // The "delete device" button which was missing from the given design
            ZStack {
                Circle()
                    .frame(height: sWidth/22.5)
                    .foregroundColor(.white)
                
                Text("-")
            }.offset(x: -0.45*sWidth, y: index != 0 ? -sHeight/16 : -sHeight/10)
            
            // Other Device Cards are similar except the "Add New Devices" card
            if index != 4 {
                ZStack {
                    VStack {
                        ZStack {
                            HStack {
                                Text(title)
                                    .font(.system(size: sHeight/30))
                                    .padding(.horizontal, sWidth/12)
                                    .foregroundColor(isOn[index] ? .black : .white)
                                    .opacity(isOn[index] ? 1 : 0.6)
                                
                                Spacer()
                                
                                ImprovedToggleButtonView(on: $isOn[index])
                                    .padding(.horizontal)
                            }
                            .frame(width: 0.9*sWidth, height: sHeight/8)
                            
                            // Changing size of system images learned from:
                            // https://stackoverflow.com/questions/57342170/how-do-i-set-the-size-of-a-sf-symbol-in-swiftui
                            Image(systemName: imagesOrder[index])
                                .font(.system(size: sHeight/30))
                        }
                        
                        Spacer()
                    }
                    
                    // AC card (index 0) is a special case because it has buttons on it
                    if index == 0 {
                        HStack {
                            Spacer()
                            WhiteCircleAddSubView(text: "-", temp: $temperature)
                            
                            Text("\(temperature) °C")
                                .font(.title)
                            
                            WhiteCircleAddSubView(text: "+", temp: $temperature)
                            Spacer()
                        }
                        .frame(height: (sHeight/4)/4)
                        .offset(y: (sHeight/5)/5)
                    }
                }
            // The "Add New Devices" card
            } else {
                HStack {
                    Text("Add New Devices")
                        .font(.bold(.title)())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    // Add new device button
                    ZStack {
                        Circle()
                            .frame(width: (sHeight/8)/2, height: (sHeight/8)/2)
                            .foregroundColor(.blue)
                        
                        Text("+")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .padding(.leading)
                }
            }
        }
        .frame(width: 0.9*sWidth, height: index != 0 ? sHeight/8 : sHeight/5)
        .padding(sHeight/500)
    }
}

// The buttons on the right-hand side of the devices used to toggle on/off state
struct ImprovedToggleButtonView: View {
    @Binding var on: Bool
    
    var body: some View {
        Button(action: {
            on.toggle()
        },
        // Look of the Button
        label: {
            ZStack {
                Rectangle()
                    .foregroundColor(on ? .blue : .lightGrey)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(sWidth/9)
                
                HStack {
                    Text(on ? "ON" : "OFF")
                        .font(.bold(.body)())
                        .foregroundColor(.white)
                }
            }
            .frame(width: sWidth/5, height: (sHeight/4)/5)
        })
    }
}
