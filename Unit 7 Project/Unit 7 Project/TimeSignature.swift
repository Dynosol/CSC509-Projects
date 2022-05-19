//
//  TimeSignature.swift
//  Unit 7 Project
//
//  Created by Sol Kim on 2/24/22.
//

import SwiftUI

// Displays the time signature and can be edited
struct TimeSignature: View {
    @ObservedObject var userModel: UserModel
    
    var body: some View {
        NavigationLink(destination: SetTimeSig(userModel: userModel), label: {
            VStack (spacing: 0){
                // Displays time signature in conventional, top/bottom format
                Text("\(userModel.user.numerator)")
                    .font(.system(size: barHeight*(0.2)))
                
                Text("\(userModel.user.denominator)")
                    .font(.system(size: barHeight*(0.2)))
            }
        })
        .buttonStyle(PlainButtonStyle())
    }
}

// The form to set the numerator and denominator of time signature
struct SetTimeSig: View {
    @ObservedObject var userModel: UserModel
    
    // Conventional time signature values
    let nums = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    let denums = [1,2,4,8,16]
    
    var body: some View {
        Form {
            // Learned picker style from: https://www.hackingwithswift.com/quick-start/swiftui/pickers-in-forms
            Picker("Numerator", selection: $userModel.user.numerator) {
                ForEach(nums, id: \.self) {Text(String($0))}
            }
            Picker("Denominator", selection: $userModel.user.denominator) {
                ForEach(denums, id: \.self) {Text(String($0))}
            }
        }
    }
}
