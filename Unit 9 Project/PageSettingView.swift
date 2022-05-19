//
//  PageSettingView.swift
//  Unit 9 Project
//
//  Created by Sol Kim on 4/28/22.
//

import SwiftUI

struct PageSettingView: View {
    @ObservedObject var userModel: UserModel
    
    @Binding var data: URLResult?
    
    var totalPages: Int
    var maxPagenum: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: sWidth, height: sHeight*(0.05))
                .foregroundColor(.silverPink)
            
            HStack {
                Text("Page")
                    .font(.custom("", size: sHeight*(0.025)))
                
                // Left/Back/Previous page
                Image(systemName: "arrowtriangle.left.fill")
                    .font(.custom("", size: sHeight*(0.025)))
                    .onTapGesture {
                        // Go back unless current page is first page
                        if userModel.user.pageShown > 0 {
                            userModel.user.pageShown -= 1
                        }
                        getData(from: "\(defaultSearch)\(userModel.currentSearch)&page=\(userModel.user.pageShown)") { data in
                            self.data = data
                        }
                    }
                
                Text("\(userModel.user.pageShown+1)")
                    .font(.custom("", size: sHeight*(0.025)))
                
                // Right/Forward/Next Page
                Image(systemName: "arrowtriangle.right.fill")
                    .font(.custom("", size: sHeight*(0.025)))
                    .onTapGesture {
                        // Prevent index out of bounds for current search
                        if userModel.user.pageShown < maxPagenum-1 {
                            userModel.user.pageShown += 1
                        }
                        
                        getData(from: "\(defaultSearch)\(userModel.currentSearch)&page=\(userModel.user.pageShown)") { data in
                            self.data = data
                        }
                    }
                
                Text("out of \(totalPages)")
                    .font(.custom("", size: sHeight*(0.025)))
            }
        }
    }
}
