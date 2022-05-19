//
//  ListView.swift
//  Unit 9 Project
//
//  Created by Sol Kim on 4/27/22.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var userModel: UserModel
    
    @State var data: URLResult?
    
    // The total number of schools returned from api call
    var totalCards: Int {
        data?.metadata.total ?? 0
    }
    
    // Number of school cards displayed per page
    var perPage: Int {
        data?.metadata.per_page ?? 0
    }
    
    var totalPages: Int {
        if totalCards > perPage {
            return (totalCards/perPage) + 1
        }
        return 1
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // CollegeSearcher title bar
            TitleView(userModel: userModel)
            
            SearchView(userModel: userModel, data: $data)
                .padding(.bottom, sHeight*(0.01))
                .background(Color.paleSilver)
            
            PageSettingView(userModel: userModel, data: $data, totalPages: totalPages, maxPagenum: totalPages)
            
            // If either the schools have come back or  there's a search error
            if (data?.metadata.total ?? 0 > 0) && (userModel.user.pageShown < totalPages){
                // Learned to hide indicator from:
                // https://stackoverflow.com/questions/58320037/is-there-a-way-to-hide-scroll-indicators-in-a-swiftui-list
                // VStack contains the ScrollView so it doesn't go out of bounds
                VStack {
                    ScrollView(showsIndicators: false) {
                        // If the current page has the max pagenum of cards
                        if (totalCards-(perPage*(data?.metadata.page ?? 1))) > perPage {
                            ForEach(0..<(data?.metadata.per_page ?? 0), id: \.self) {i in
                                CardView(userModel: userModel, school: data?.results[i] ?? DefaultSchool)
                            }
                        } else {
                            // If the current page has less than the max pagenum
                            ForEach(0..<(totalCards-(perPage*(data?.metadata.page ?? 1))), id: \.self) {i in
                                CardView(userModel: userModel, school: data?.results[i] ?? DefaultSchool)
                            }
                        }
                    }
                }
                .frame(height: sHeight*(0.72))
            }
            // Search failure
            else if (data?.metadata.total == 0) {
                Spacer()
                
                Text("\(data?.errors?[0].message ?? "There were no results for your search. Try again.")")
                
                Spacer()
            }
            // No data received at all
            else {
                Spacer()
                
                Text("There was an error. Try again")
                
                Spacer()
            }
        }
        // Gradient learned from:
        // https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-gradient
        .background(
            LinearGradient(gradient: Gradient(colors: [.bone, .darkBone]), startPoint: .top, endPoint: .bottom)
        )
        .edgesIgnoringSafeArea(.all)
        // On appear, display current search data
        .onAppear {
            getData(from: "\(defaultSearch)\(userModel.currentSearch)&page=\(userModel.user.pageShown)") { data in
                self.data = data
            }
        }
    }
}
