//
//  SchoolDetailView.swift
//  Unit 9 Project
//
//  Created by Sol Kim on 4/30/22.
//

import SwiftUI

struct SchoolDetailView: View {
    @ObservedObject var userModel: UserModel
    
    var school: School
    
    var body: some View {
        // List of school information
        List {
            Text("\(school.name)")
                .font(.system(size: sWidth*(0.05), weight: .heavy, design: .default))
            
            // Method to get rid of extra argument error from:
            // https://stackoverflow.com/questions/61178868/swiftui-random-extra-argument-in-call-error
            Group {
                InfoText(text: "Location: \(school.city), \(states[school.state_fips] ?? "N/A")")
                InfoText(text: "Locale: \(locales[school.locale] ?? "N/A")")
                InfoText(text: "Undergrad Population: \(school.size ?? 0)", bold: true)
                InfoText(text: "Graduate Population: \(school.grad_students ?? 0)")
                InfoText(text: "POC Population: \((1-((school.white) ?? 0.0))*100)%")
                InfoText(text: "Average Degree Awarded: \(degreeType[school.degrees_awarded] ?? "N/A")")
                InfoText(text: "School Ownership: \(ownership[school.ownership] ?? "N/A")")
                InfoText(text: "Pell Grant Rate: \((school.pell_grant_rate ?? 0)*100)%")
                InfoText(text: "Average Yearly Cost: $\(school.academic_year ?? 0)")
                InfoText(text: "Undergrads on Pell Grant or Loan: \((Double(school.undergrads_with_pell_grant_or_federal_student_loan ?? 0))/100)%")
            }
            
            // If the link is valid, display it
            if school.school_url != nil && URL(string: "https://\(school.school_url!)") != nil{
                // HStack method used to center link in list view
                HStack {
                    Spacer()
                    // Link learned from:
                    // https://developer.apple.com/documentation/swiftui/link
                    Link("School Website", destination: URL(string: "https://\(school.school_url!)")!)
                        .foregroundColor(.blue)
                    Spacer()
                }
            }
            
            // If the link is valid, display it
            if school.price_calculator_url != nil && URL(string: "https://\(String(describing: school.price_calculator_url))") != nil {
                // HStack method used to center link in list view
                HStack {
                    Spacer()
                    Link("Net Price Calculator", destination: URL(string: "https://\(school.price_calculator_url!)")!)
                        .foregroundColor(.blue)
                    Spacer()
                }
            }
        }
    }
}

// expanded text view used to standardize font size and select boldness
struct InfoText: View {
    var text: String
    var bold: Bool = false
    
    var body: some View {
        if !bold {
            Text(text)
                .font(.custom("", size: sHeight*(0.015)))
        } else {
            Text(text)
                .font(.system(size: sHeight*(0.015), weight: .heavy, design: .default))
        }
    }
}
