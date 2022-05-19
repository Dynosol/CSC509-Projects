//
//  CardView.swift
//  Unit 9 Project
//
//  Created by Sol Kim on 4/27/22.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var userModel: UserModel
    
    var school: School
     
    var body: some View {
        ZStack {
            // Background rectangles and outline
            Rectangle()
                .frame(width: sWidth*(0.95), height: sHeight*(0.2))
                .cornerRadius(sWidth*(0.05))
                .foregroundColor(.paleSilver)
            Rectangle()
                .frame(width: sWidth*(0.93), height: sHeight*(0.19))
                .cornerRadius(sWidth*(0.04))
                .foregroundColor(.white)
                // Learned shadow from: https://www.hackingwithswift.com/quick-start/swiftui/how-to-draw-a-shadow-around-a-view
                .shadow(color: .lessSilverPink, radius: sWidth*(0.02))
            
            VStack {
                Text(school.name)
                    .font(.system(size: sHeight*(0.03), weight: .heavy, design: .default))
                    .multilineTextAlignment(.center)
                
                Text("\(school.city), \(states[school.state_fips] ?? "Loading State...")")
                    .font(.custom("", size: sHeight*(0.015))).bold()
                
                HStack {
                    // Redirects to detailed school information page
                    NavigationLink(destination: SchoolDetailView(userModel: userModel, school: school), label: {
                        Text("See More Info")
                            .font(.custom("", size: sHeight*(0.015))).bold()
                            .foregroundColor(.white)
                            .padding(sWidth*(0.03))
                            .background(Color.blue)
                            .cornerRadius(sWidth*(0.02))
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    // Quick array check learned from:
                    // https://stackoverflow.com/questions/24102024/how-to-check-if-an-element-is-in-an-array
                    // Button to save school to saved schools
                    Button {
                        if !(userModel.user.savedSchools.contains(school)) {
                            userModel.user.savedSchools.append(school)
                        } else {
                            // Filter method from:
                            // https://stackoverflow.com/questions/24051633/how-to-remove-an-element-from-an-array-in-swift
                            userModel.user.savedSchools = userModel.user.savedSchools.filter { $0 != school }
                        }
                    } label: {
                        // If already saved, say 'remove from list'
                        Text((!userModel.user.savedSchools.contains(school)) ? "Add To List" : "Remove from List")
                            .font(.custom("", size: sHeight*(0.015))).bold()
                            .foregroundColor(.white)
                            .padding(sWidth*(0.03))
                            // Green if not saved, red if saved
                            .background((!userModel.user.savedSchools.contains(school)) ? Color.green : Color.red)
                            .cornerRadius(sWidth*(0.02))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }.frame(width: sWidth*(0.90), height: sHeight*(0.19))
        }
    }
}
