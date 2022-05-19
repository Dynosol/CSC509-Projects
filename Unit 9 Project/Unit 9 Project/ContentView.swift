//
//  ContentView.swift
//  Unit 9 Project
//
//  Created by Sol Kim on 4/21/22.
//

// Sources Cited
// 1. https://stackoverflow.com/questions/58516229/how-to-add-a-new-swiftui-color
// 2. https://www.hackingwithswift.com/read/0/7/dictionaries
// 3. https://www.appcoda.com/swiftui-search-bar/
// 4. https://stackoverflow.com/questions/3439853/replace-occurrences-of-space-in-url
// 5. https://www.hackingwithswift.com/quick-start/swiftui/how-to-draw-a-shadow-around-a-view
// 6. https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-gradient
// 7. https://stackoverflow.com/questions/58320037/is-there-a-way-to-hide-scroll-indicators-in-a-swiftui-list
// 8. https://stackoverflow.com/questions/68900579/how-to-omit-argument-name-in-a-struct
// 9. https://stackoverflow.com/questions/61178868/swiftui-random-extra-argument-in-call-error
// 10. https://stackoverflow.com/questions/24102024/how-to-check-if-an-element-is-in-an-array
// 11. https://stackoverflow.com/questions/24051633/how-to-remove-an-element-from-an-array-in-swift
// 12. https://developer.apple.com/documentation/swiftui/link
// 13. https://stackoverflow.com/questions/60885532/how-to-detect-swiping-up-down-left-and-right-with-swiftui-on-a-view
// 14. https://www.hackingwithswift.com/books/ios-swiftui/animating-gestures

// API doc: https://github.com/RTICWDT/open-data-maker/blob/master/API.md
// API info: https://docs.google.com/spreadsheets/d/1zXI33lzzly5kcjq9M_RXp1Y5eehdQYN5/edit#gid=1378017126

import SwiftUI

// Global constants for scaling views
let sWidth = UIScreen.main.bounds.width
let sHeight = UIScreen.main.bounds.height

// Global custom color variables
// Once again, learned color extension from:
// https://stackoverflow.com/questions/58516229/how-to-add-a-new-swiftui-color
extension Color {
    static let paleSilver = Color(red: 191/255, green: 181/255, blue: 175/255)
    static let bone = Color(red: 236/255, green: 226/255, blue: 208/255)
    static let darkBone = Color(red: 186/255, green: 176/255, blue: 158/255)
    static let silverPink = Color(red: 213/255, green: 185/255, blue: 178/255)
    static let lessSilverPink = Color(red: 203/255, green: 175/255, blue: 168/255)
}

// Default API call without search or page specifics
let defaultSearch = "https://api.data.gov/ed/collegescorecard/v1/schools?api_key=E6te95bs1IqrPUUAf69hOLajpwPuE0PpNdDwdK1t&fields=school.name,school.state_fips,school.city,school.locale,2019.student.size,2019.student.undergrads_with_pell_grant_or_federal_student_loan,2019.student.grad_students,2019.student.demographics.race_ethnicity.white,school.school_url,school.price_calculator_url,school.degrees_awarded.predominant,school.ownership,2019.aid.pell_grant_rate,2019.cost.attendance.academic_year,2019.student.undergrads_with_pell_grant_or_federal_student_loan"

struct ContentView: View {
    @StateObject var userModel = UserModel(user: UserItem(savedSchools: [], pageShown: 0), currentSearch: "")
    
    var body: some View {
        TabView {
            NavigationView {
                // Searching schools and listing all schools
                ListView(userModel: userModel)
                    .navigationBarHidden(true)
            }
            .tabItem {
                Label("List", systemImage: "list.dash")
            }
            // Forces lightmode (not compatible with darkmode)
            .preferredColorScheme(.light)

            NavigationView {
                // List of saved schools
                SavedView(userModel: userModel)
                    .navigationBarHidden(true)
            }
            .tabItem {
                Label("Saved", systemImage: "archivebox")
            }
            .preferredColorScheme(.light)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
