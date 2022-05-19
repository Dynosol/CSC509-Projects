//
//  DeviceCardView.swift
//  Unit 4 Project
//
//  Created by Sol Kim on 11/9/21.
//

import SwiftUI

// How a device "card" looks
struct BadDeviceCardView: View {
    var index: Int
    var title: String
    var color: Color
    @Binding var temperature: Int
    
    var body: some View {
        ZStack {
            // Background rectangle
            Rectangle()
                .frame(width: 0.9*sWidth, height: sHeight/4)
                .foregroundColor(color)
                .cornerRadius(0.08*sWidth)
                .padding(0.01*sWidth)
            
            // Other Device Cards are similar except the "Add New Devices" card
            if index != 2 {
                ZStack {
                    VStack {
                        HStack {
                            Text(title)
                                .font(.title2)
                                .padding(.horizontal)

                            Spacer()
                            
                            ToggleButtonView()
                                .padding(.horizontal)
                        }
                        .frame(width: 0.9*sWidth, height: sHeight/8)
                        
                        Spacer()
                    }
                    
                    // AC card (index 0) is a special case because it has buttons on it
                    if index == 0 {
                        VStack {
                            Text("Cooling")
                            HStack {
                                WhiteCircleAddSubView(text: "-", temp: $temperature)
                                
                                Text("\(temperature)")
                                    .font(.bold(.largeTitle)())
                                
                                WhiteCircleAddSubView(text: "+", temp: $temperature)
                            }
                            .frame(height: (sHeight/4)/4)
                            Text("°C")
                        }
                    // Light card (index 1) has lightbulb images on it
                    } else {
                        VStack {
                            Image("lightbulbs")
                                .resizable()
                                .frame(width: sWidth/4, height: (sHeight/4)*0.8)
                                .offset(y: -(sHeight/4)*0.1)
                        }
                        .frame(width: sWidth/4, height: (sHeight/4)*0.8)
                    }
                }
            // The "Add New Devices" card
            } else {
                ZStack {
                    VStack {
                        Text("Add New Devices")
                            .font(.bold(.largeTitle)())
                            .foregroundColor(.white)
                            .frame(width: sWidth/2, height: (sHeight/4)/2)
                            .multilineTextAlignment(.center)
                        
                        ZStack {
                            Rectangle()
                                .frame(width: sWidth/4, height: (sHeight/4)/4)
                                .cornerRadius(sHeight/20)
                                .foregroundColor(.white)
                            
                            Text("Add")
                        }
                    }
                    
                    HStack {
                        ColoredRectangleView(color: .lightBlue)
                        Spacer()
                        ColoredRectangleView(color: .togglePurple)
                    }
                }
            }
        }
        .frame(width: 0.9*sWidth, height: sHeight/4)
    }
}

// How the "ON" toggle button looks on a Device Card
struct ToggleButtonView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(sWidth/9)
            
            HStack {
                Text("ON")
                    .font(.bold(.body)())
                
                Circle()
                    .frame(height: sWidth/11)
                    .foregroundColor(.togglePurple)
            }
        }
        .frame(width: sWidth/7, height: (sHeight/4)/7)
    }
}

// The white circle buttons used to add/subtract temperature in the AC card
struct WhiteCircleAddSubView: View {
    var text: String
    @Binding var temp: Int
    
    var body: some View {
        Button(action: {
            temp += Int("\(text)1")!
        }, label: {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                Text(text)
                    .font(.title)
            }
        })
    }
}

// The colored rectangles used to mimic the given design's designs
struct ColoredRectangleView: View {
    var color: Color
    
    var body: some View {
        Rectangle()
            .frame(width: sWidth/6, height: (sHeight/4)/2)
            .foregroundColor(color)
            .padding(.horizontal)
    }
}
