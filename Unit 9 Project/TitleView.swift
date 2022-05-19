//
//  TitleView.swift
//  Unit 9 Project
//
//  Created by Sol Kim on 4/28/22.
//

import SwiftUI

struct TitleView: View {
    @ObservedObject var userModel: UserModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: sWidth, height: sHeight*(0.1))
                .foregroundColor(.paleSilver)
            
            Text("CollegeSearcher")
                .font(.custom("", size: sWidth*(0.08)))
                .padding(.top, sHeight*(0.03))
        }
    }
}


