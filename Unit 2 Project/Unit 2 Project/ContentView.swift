//
//  ContentView.swift
//  Unit 2 Project
//
//  Created by Sol Kim on 10/9/21.
//

// Sourscces Cited
//1) https://blog.waldo.io/swiftui-form-101/
//2) https://www.hackingwithswift.com/quick-start/swiftui/basic-form-design
//3) https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-select-a-color-with-colorpicker
//4) https://www.simpleswiftguide.com/how-to-create-and-use-picker-with-form-in-swiftui/
//5) https://www.appcoda.com/learnswiftui/swiftui-text.html
//6) https://stackoverflow.com/questions/24037711/get-the-length-of-a-string
//7) https://stackoverflow.com/questions/56443535/swiftui-text-alignment
//8) https://www.hackingwithswift.com/read/0/11/functions
//9) https://www.agnosticdev.com/content/how-get-first-or-last-characters-string-swift-4
//10) https://medium.com/analytics-vidhya/shapes-with-paths-using-swiftui-part1-fb7250d3dce8

// Images from:
//1) https://www.transparentpng.com/cats/facebook-logo-1901.html
//2) https://icon-icons.com/icon/brand-instagram/151534
//3) https://icon-icons.com/icon/linkedin-black-logo/147114

import SwiftUI

let defaultCardColor = Color(red: 199/255, green: 189/255, blue: 143/255)
let businessCardRatio = CGFloat(1.586)
let pWidth = UIScreen.main.bounds.width

struct ContentView: View {
    var body: some View {
        FormCreationView()
    }
}

struct FormCreationView: View {
    /// LINE TO DELETE
    // Card customizability options
    var fontSizes = ["Small", "Medium", "Large"]
    var cardStyles = ["Clean", "Chrome", "Minimal"]
    
    @State private var selectedFontsizeIndex = 1
    @State private var selectedCardstyleIndex = 0
    // Learned how to create a color picker from:
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-select-a-color-with-colorpicker
    @State private var bgColor = defaultCardColor
    
    @State var name = ""
    @State var jobTitle = ""
    @State var companyName = ""
    @State var address = ""
    @State var phoneNumber = ""
    @State var email = ""
    @State var facebook = ""
    @State var instagram = ""
    @State var linkedin = ""
    @State var website = ""
    
    var body: some View {
        NavigationView {
            Form {
                // Empty header for subtitle text
                Section (header: Text("Enter information as you would like it to appear on the card")){}
                Section (header: Text("Essential Information")) {
                    TextField("Name", text: $name)
                    TextField("Job Title", text: $jobTitle)
                    TextField("Company Name", text: $companyName)
                }
                
                Section (header: Text("Contact Info (at least one required)")) {
                    TextField("Phone Number", text: $phoneNumber)
                    TextField("Email", text: $email)
                    TextField("Facebook", text: $facebook)
                    TextField("Instagram", text: $instagram)
                    TextField("Linkedin", text: $linkedin)
                    TextField("Website", text: $website)
                }
                
                Section (header: Text("Optional Information")) {
                    TextField("Work or Home Address", text: $address)
                }
                
                // Learned how to create a Picker from:
                // https://www.simpleswiftguide.com/how-to-create-and-use-picker-with-form-in-swiftui/
                
                // Where users pick size and style using pickers
                Section (header: Text("Card Customizeability")) {
                    Picker(selection: $selectedFontsizeIndex, label: Text("Font Size")) {
                        ForEach(0 ..< fontSizes.count) {
                            Text(self.fontSizes[$0])
                        }
                    }
                    Picker(selection: $selectedCardstyleIndex, label: Text("Card Style")) {
                        ForEach(0 ..< cardStyles.count) {
                            Text(self.cardStyles[$0])
                        }
                    }
                    ColorPicker("Set the background color", selection: $bgColor)
                }
                
                // If user chooses "Clean" style
                if selectedCardstyleIndex == 0 {
                    NavigationLink(
                        destination:
                            CardView1(name: self.name, jobTitle: self.jobTitle, companyName: self.companyName, address: self.address, phoneNumber: self.phoneNumber, email: self.email, facebook: self.facebook, instagram: self.instagram, linkedin: self.linkedin, website: self.website, selectedFontsizeIndex: self.selectedFontsizeIndex, bgColor: self.bgColor),
                        label: {
                            if atLeastOneContact(pnumber: self.phoneNumber, email: self.email, facebook: self.facebook, instagram: self.instagram, linkedin: self.linkedin, website: self.website) == true {
                                Text("Build card")
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            }
                        })
                }
                
                // If user chooses "Chrome" style
                if selectedCardstyleIndex == 1 {
                    NavigationLink(
                        destination:
                            CardView2(name: self.name, jobTitle: self.jobTitle, companyName: self.companyName, address: self.address, phoneNumber: self.phoneNumber, email: self.email, facebook: self.facebook, instagram: self.instagram, linkedin: self.linkedin, website: self.website, selectedFontsizeIndex: self.selectedFontsizeIndex, bgColor: self.bgColor),
                        label: {
                            if atLeastOneContact(pnumber: self.phoneNumber, email: self.email, facebook: self.facebook, instagram: self.instagram, linkedin: self.linkedin, website: self.website) == true {
                                    Text("Build card")
                                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                }
                    })
                }
                
                // If user chooses "Minimal" style
                if selectedCardstyleIndex == 2 {
                    NavigationLink(
                        destination:
                            CardView3(name: self.name, jobTitle: self.jobTitle, companyName: self.companyName, address: self.address, phoneNumber: self.phoneNumber, email: self.email, facebook: self.facebook, instagram: self.instagram, linkedin: self.linkedin, website: self.website, selectedFontsizeIndex: self.selectedFontsizeIndex, bgColor: self.bgColor),
                        label: {
                            if atLeastOneContact(pnumber: self.phoneNumber, email: self.email, facebook: self.facebook, instagram: self.instagram, linkedin: self.linkedin, website: self.website) == true {
                                    Text("Build card")
                                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                }
                    })
                }
            }
            .navigationBarTitle("Create New Card")
        }
    }
}
    

// CLEAN STYLE
struct CardView1: View {
    var name: String
    var jobTitle: String
    var companyName: String
    var address: String
    var phoneNumber: String
    var email: String
    var facebook: String
    var instagram: String
    var linkedin: String
    var website: String
    
    var selectedFontsizeIndex: Int
    var bgColor = defaultCardColor
    
    var body: some View {
        NavigationView {
            /// LINE TO DELETE
        // Vertical Stack of front and back view of cards
            VStack {
                /// LINE TO DELETE
                // Front face of the card
                ZStack {
                    // Card Background
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: pWidth, height: pWidth/businessCardRatio)
                    
                    // Background shapes of the card
                    HStack (spacing: 0) {
                        Rectangle()
                            .fill(bgColor)
                            .frame(width: pWidth*0.4, height: pWidth/businessCardRatio)
                        
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: pWidth*0.01, height: pWidth/businessCardRatio)
                        
                        Spacer()
                        
                        ZStack {
                            Card1CircleView(color: self.bgColor, companyName: self.companyName)
                        }
                        
                        Spacer()
                    }
                    
                    // Information on the left hand side
                    HStack {
                        LeftSideInfoView(name: self.name, jobTitle: self.jobTitle, companyName: self.companyName, address: self.address, phoneNumber: self.phoneNumber, email: self.email, facebook: self.facebook, instagram: self.instagram, linkedin: self.linkedin, website: self.website, selectedFontsizeIndex: self.selectedFontsizeIndex, horizPad: pWidth*(2/414), vertPad: pWidth*(30/414), width: pWidth*0.4, height: pWidth/businessCardRatio)
                        
                        Spacer()
                    }
                }
                .frame(width: pWidth, height: pWidth/businessCardRatio)
                .padding()
                
                // Backside of card
                ZStack {
                    Rectangle()
                        .fill(bgColor)
                        .frame(width: pWidth, height: pWidth/businessCardRatio)
                    Card1CircleView(color: Color.white, companyName: self.companyName)
                    
                }
            }
            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.black)
            .ignoresSafeArea()
        }
    }
}


// CHROME STYLE
struct CardView2: View {
    var name: String
    var jobTitle: String
    var companyName: String
    var address: String
    var phoneNumber: String
    var email: String
    var facebook: String
    var instagram: String
    var linkedin: String
    var website: String
    
    var selectedFontsizeIndex: Int
    var bgColor = defaultCardColor
    
    var body: some View {
        NavigationView {
            /// LINE TO DELETE
        // Vertical Stack of front and back view of cards
            VStack {
                /// LINE TO DELETE
                // Front face of the card
                ZStack {
                    // Card Background
                    Rectangle()
                        .fill(bgColor)
                        .frame(width: pWidth, height: pWidth/businessCardRatio)
                    
                    // Background shapes of the card
                    HStack (spacing: 0) {
                        Spacer()
                        Triangle()
                            .fill(Color.gray)
                            .frame(width: pWidth*0.6, height: pWidth/businessCardRatio)
                    }
                    
                    // Information on the left hand side
                    HStack {
                        LeftSideInfoView(name: self.name, jobTitle: self.jobTitle, companyName: self.companyName, address: self.address, phoneNumber: self.phoneNumber, email: self.email, facebook: self.facebook, instagram: self.instagram, linkedin: self.linkedin, website: self.website, selectedFontsizeIndex: self.selectedFontsizeIndex, horizPad: pWidth*(15/414), vertPad: pWidth*(30/414), width: pWidth*0.5, height: pWidth/businessCardRatio)
                        
                        Spacer()
                    }
                }
                .frame(width: pWidth, height: pWidth/businessCardRatio)
                .padding()
                
                // Backside of card
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: pWidth, height: pWidth/businessCardRatio)
                    HStack(spacing: 0) {
                        Triangle()
                            .fill(bgColor)
                            .frame(width: pWidth*0.6, height: pWidth/businessCardRatio)
                        Rectangle()
                            .fill(bgColor)
                            .frame(width: pWidth*0.4, height: pWidth/businessCardRatio)
                    }
                    HStack {
                        Spacer()
                        Text(self.companyName)
                            .font(.custom("Merriweather-Regular", size: pWidth*(35/414)))
                            .frame(width: pWidth*0.40, height: pWidth*0.40)
                            .multilineTextAlignment(.trailing)
                            .padding(pWidth*(30/414))
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.black)
            .ignoresSafeArea()
        }
    }
}


// MINIMAL STYLE
struct CardView3: View {
    var name: String
    var jobTitle: String
    var companyName: String
    var address: String
    var phoneNumber: String
    var email: String
    var facebook: String
    var instagram: String
    var linkedin: String
    var website: String
    
    var selectedFontsizeIndex: Int
    var bgColor = defaultCardColor
    
    var body: some View {
        NavigationView {
            /// LINE TO DELETE
        // Vertical Stack of front and back view of cards
            VStack {
                /// LINE TO DELETE
                // Front face of the card
                ZStack {
                    // Card Background
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: pWidth, height: pWidth/businessCardRatio)
                    
                    // Information in the center
                    HStack {
                        VStack (alignment: .center, spacing: pWidth*(2/414)) {
                            SimpleTextView(text: self.name, multi: self.selectedFontsizeIndex, size: (20/414))
                            SimpleTextView(text: self.jobTitle, multi: self.selectedFontsizeIndex, size: (16/414))
                            
                            Spacer()
                            
                            if self.phoneNumber.count != 0 {Text(self.phoneNumber)
                                .font(.custom("Merriweather-Regular", size: pWidth*(12/414)*textScaling(multiplier: self.selectedFontsizeIndex)))}
                            
                            if self.email.count != 0 {Text(self.email)
                                .font(.custom("Merriweather-Regular", size: pWidth*(12/414)*textScaling(multiplier: self.selectedFontsizeIndex)))}
                            
                            // The "MINIMAL" style has a horizontal stack of socials
                            HStack (spacing: pWidth*(5/414)){
                                if self.facebook.count != 0 {
                                    IconTextView(text: " \(self.facebook)", imageName: "facebook", multi: self.selectedFontsizeIndex)
                                }
                                
                                if self.instagram.count != 0 {
                                    IconTextView(text: " \(instagramHandler(username: self.instagram))", imageName: "insta", multi: self.selectedFontsizeIndex)
                                }
                                
                                if self.linkedin.count != 0 {
                                    IconTextView(text: " \(self.linkedin)", imageName: "linked", multi: self.selectedFontsizeIndex)
                                }
                            }
                            
                            SimpleTextView(text: self.website,multi: self.selectedFontsizeIndex, size: (12/414))
                        }.padding(.horizontal, pWidth*(2/414))
                        .padding(.vertical, pWidth*(50/414))
                    }
                }
                .frame(width: pWidth, height: pWidth/businessCardRatio)
                .padding()
                
                // Backside of card
                ZStack {
                    Rectangle()
                        .fill(bgColor)
                        .frame(width: pWidth, height: pWidth/businessCardRatio)
                    Text(self.companyName)
                        .font(.custom("Merriweather-Regular", size: pWidth*(50/414)))
                    
                }
            }
            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.black)
            .ignoresSafeArea()
        }
    }
}


// In both "CLEAN" and "CHROME" styles, this is the general format of how information is displayed
struct LeftSideInfoView: View {
    var name: String
    var jobTitle: String
    var companyName: String
    var address: String
    var phoneNumber: String
    var email: String
    var facebook: String
    var instagram: String
    var linkedin: String
    var website: String
    
    var selectedFontsizeIndex: Int
    
    var horizPad: CGFloat
    var vertPad: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        VStack (alignment: .leading, spacing: pWidth*(2/414)) {
            SimpleTextView(text: self.name, multi: self.selectedFontsizeIndex, size: (20/414))
            SimpleTextView(text: self.jobTitle, multi: self.selectedFontsizeIndex, size: (16/414))
            
            Spacer()
            
            // Learned how to get length of a string from:
            // https://stackoverflow.com/questions/24037711/get-the-length-of-a-string
            // Makes optional parameters only take up space if they are entered
            if self.phoneNumber.count != 0 {Text(self.phoneNumber)
                // This function (and every time it appears after this) scales the font depending on the size the user chose
                .font(.custom("Merriweather-Regular", size: pWidth*(12/414)*textScaling(multiplier: self.selectedFontsizeIndex)))}
            
            if self.email.count != 0 {Text(self.email)
                .font(.custom("Merriweather-Regular", size: pWidth*(12/414)*textScaling(multiplier: self.selectedFontsizeIndex)))}
            
            // Facebook logo from: https://www.transparentpng.com/cats/facebook-logo-1901.html
            if self.facebook.count != 0 {
                // Using string interpolation to shift the text slightly away from the icon
                IconTextView(text: " \(self.facebook)", imageName: "facebook", multi: self.selectedFontsizeIndex)
            }
            
            // Instagram logo from: https://icon-icons.com/icon/brand-instagram/151534
            if self.instagram.count != 0 {
                IconTextView(text: " \(instagramHandler(username: self.instagram))", imageName: "insta", multi: self.selectedFontsizeIndex)
            }
            
            // Linkedin logo from: https://icon-icons.com/icon/linkedin-black-logo/147114
            if self.linkedin.count != 0 {
                IconTextView(text: " \(self.linkedin)", imageName: "linked", multi: self.selectedFontsizeIndex)
            }
            
            SimpleTextView(text: self.website,multi: self.selectedFontsizeIndex, size: (12/414))

        }.padding(.horizontal, self.horizPad)
        .padding(.vertical, self.vertPad)
        .frame(width: self.width, height: self.height)
    }
}

// View for displaying icon and attribute: ie the instagram logo and username
struct IconTextView: View {
    var text: String
    var imageName: String
    var multi: Int
    
    var body: some View {
        HStack (spacing: 0){
            Image(self.imageName)
                .resizable()
                .frame(width: pWidth*(12/414)*textScaling(multiplier: self.multi), height: pWidth*(12/414)*textScaling(multiplier: self.multi))
            Text(self.text)
                .font(.custom("Merriweather-Regular", size: pWidth*(12/414)*textScaling(multiplier: self.multi)))
        }
    }
}

// View for the normal text (text other than the text with icons next to it)
struct SimpleTextView: View {
    var text: String
    var multi: Int
    var size: CGFloat
    
    var body: some View {
        if text.count != 0 {Text(text)
            .font(.custom("Merriweather-Regular", size: pWidth*(self.size)*textScaling(multiplier: self.multi)))}
    }
}

// The circle shape in the "clean" card
struct Card1CircleView: View {
    var color: Color
    var companyName: String
    
    var body: some View {
        // Learned to make a circle from:
        // https://www.hackingwithswift.com/quick-start/swiftui/how-to-display-solid-shapes
        Circle()
            .fill(Color.black)
            .frame(width: pWidth*0.5, height: pWidth*0.5)
        Circle()
            .fill(self.color)
            .frame(width: pWidth*0.48, height: pWidth*0.48)
        // Learned how to center-align text from:
        // https://stackoverflow.com/questions/56443535/swiftui-text-alignment
        Text(self.companyName)
            .font(.custom("Merriweather-Regular", size: pWidth*(30/414)))
            .frame(width: pWidth*0.38, height: pWidth*0.38)
            .multilineTextAlignment(.center)
    }
}

// The triangle shape in the "chrome" card
// Code based on code from this source: https://medium.com/analytics-vidhya/shapes-with-paths-using-swiftui-part1-fb7250d3dce8
struct Triangle: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    return path
  }
}

// Learned about functions from:
// https://www.hackingwithswift.com/read/0/11/functions

// Puts an @ sign in from of their username if they didn't put it
func instagramHandler(username: String) -> String {
    // Learned about prefix from:
    // https://www.agnosticdev.com/content/how-get-first-or-last-characters-string-swift-4
    if username.prefix(1) == "@" {return username}
    else {return "@\(username)"}
}

// Checks if the email string contains the necessary "@" sign and ".com" or ".<something>"
func emailSanitize(email: String) -> Bool {
    return (email.contains("@") && email.contains("."))
}

// Function for scaling text
func textScaling(multiplier: Int) -> CGFloat {
    return CGFloat((0.25)*Double(multiplier) + (0.75))
}

// Checking if the user put at least one contact information
func atLeastOneContact(
        pnumber: String,
        email: String,
        facebook: String,
        instagram: String,
        linkedin: String,
        website: String
    ) -> Bool {
    // Checks if there is anything typed at all in any of the six categories
        if "\(pnumber)+\(email)+\(facebook)+\(instagram)+\(linkedin)+\(website)" != "" {return true}
        return false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
