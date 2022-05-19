//
//  SavedView.swift
//  Unit 9 Project
//
//  Created by Sol Kim on 4/27/22.
//

import SwiftUI

struct SavedView: View {
    @ObservedObject var userModel: UserModel
    
    var body: some View {
        VStack(spacing: 0) {
            TitleView(userModel: userModel)
            
            // If user has saved any schools, display them all
            if userModel.user.savedSchools.count > 0 {
                ScrollView(showsIndicators: false) {
                    ForEach(0..<userModel.user.savedSchools.count, id: \.self) {i in
                        CardView(userModel: userModel, school: userModel.user.savedSchools[i])
                    }
                }
                .frame(height: sHeight*(0.81))
                // Makes ScrollView go underneath the title bar
                .zIndex(-1)
            // If no schools have been saved
            } else {
                Spacer()
                
                Text("Save schools to have them appear here.")
                
                Spacer()
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.bone, .darkBone]), startPoint: .top, endPoint: .bottom)
        )
        .edgesIgnoringSafeArea(.all)
    }
}
