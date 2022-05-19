//
//  SearchView.swift
//  Unit 9 Project
//
//  Created by Sol Kim on 4/28/22.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var userModel: UserModel
    
    @Binding var data: URLResult?
    @State var input: String = ""
    
    var body: some View {
        // Code based on: https://www.appcoda.com/swiftui-search-bar/
        HStack(spacing: 0) {
            // Search bar
            TextField("Enter School Name...", text: $input)
                .padding(sWidth*(0.01))
                .padding(.leading, sWidth*(0.05))
                .background(Color(.systemGray6))
                .cornerRadius(sWidth*(0.05))
                .padding(.leading, sWidth*(0.03))
                .padding(.trailing, sWidth*(0.05))

            // Search button
            Text("Search")
                .padding(sWidth*(0.01))
                .padding(.horizontal, sWidth*(0.02))
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(sWidth*(0.05))
                .padding(.trailing, sWidth*(0.1))
                .onTapGesture {
                    // Save current search
                    userModel.currentSearch = "&school.name=\(convertedInput(input: input))"
                    // Reset page number
                    userModel.user.pageShown = 0
                    
                    // If empty query, return to default listing of all schools
                    if input == "" {
                        userModel.currentSearch = ""
                    }
                    
                    getData(from: "\(defaultSearch)\(userModel.currentSearch)&page=\(userModel.user.pageShown)") { data in
                        self.data = data
                    }
                }
        }
    }
}

// Method learned from: https://stackoverflow.com/questions/3439853/replace-occurrences-of-space-in-url
// Converts spaces in string into %20, so that it is searchable
func convertedInput(input: String) -> String{
    let output = input.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "Error Occurred"
    return output
}
