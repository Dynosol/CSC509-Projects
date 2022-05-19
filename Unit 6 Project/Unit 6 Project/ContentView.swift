//
//  ContentView.swift
//  Unit 6 Project
//
//  Created by Sol Kim on 1/18/22.
//

// Sources cited
//1) https://www.hackingwithswift.com/forums/swiftui/foreach-with-array-binding-crash-on-item-deletion/7394
//2) https://www.hackingwithswift.com/books/ios-swiftui/working-with-identifiable-items-in-swiftui
//3) https://www.hackingwithswift.com/forums/swiftui/removing-unwanted-and-unknown-whitespace-possibly-a-navigation-bar-above-a-view/7343
//4) https://www.hackingwithswift.com/example-code/language/removing-matching-elements-from-a-collection-removeallwhere
//5) https://sarunw.com/posts/how-to-present-alert-in-swiftui-ios13/
//6) https://developer.apple.com/documentation/swift/equatable
//7) https://flaviocopes.com/swiftui-forms-toggle/
//8) https://developer.apple.com/documentation/swiftui/text/multilinetextalignment(_:)
//9) https://stackoverflow.com/questions/62969859/swiftui-randomly-crashes-on-presentationmode-wrappedvalue-dismiss
//10) https://developer.apple.com/documentation/swiftui/view/border(_:width:)
//11) https://stackoverflow.com/questions/39677330/how-does-string-substring-work-in-swift
//ALL IMAGES FROM: https://www.spriters-resource.com/

import SwiftUI

// Width and height global constants used for scaling sizes
let sWidth = UIScreen.main.bounds.width
let sHeight = UIScreen.main.bounds.height

// Global custom color variables
// Once again, learned color extension from:
// https://stackoverflow.com/questions/58516229/how-to-add-a-new-swiftui-color
extension Color {
    static let darkTan = Color(red: 189/255, green: 184/255, blue: 168/255)
    static let backgroundColor = Color(red: 210/255, green: 210/255, blue: 210/255)
    static let darkGray = Color(red: 50/255, green: 50/255, blue: 50/255)
}

struct ContentView: View {
    @StateObject var playerModel = PlayerModel(cards:
    [
        Card(title: "First Card!", desc: "Hey this is me, the real Bob Dylan making a card.", highval: false, completed: false),
        Card(title: "Grocery List", desc: "bananas, salt, bell peppers, lettuce, rice, flour, asparagus", highval: true, completed: false)
    ], coins: 0, inv: defaultShop, username: "Default Name", showPopups: true, myColor: [255, 214, 89], logons: 0)
    
    @State private var welcomeAlert = !UserDefaults.standard.bool(forKey: "pop")
    
    var body: some View {
        TabView {
            NavigationView {
                HomeScreen(playerModel: playerModel)
                    .navigationTitle("")
                    .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
                
            NavigationView {
                ShopScreen(playerModel: playerModel)
            }
            .tabItem {
                Image(systemName: "bag.circle")
                Text("Shop")
            }
            
            NavigationView {
                InventoryScreen(playerModel: playerModel)
            }
            .tabItem {
                Image(systemName: "shippingbox")
                Text("Inventory")
            }
                
            NavigationView {
                SettingScreen(playerModel: playerModel)
            }
            .tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }
        // Every time the app is opened, user gains bonus coins
        .onAppear {
            playerModel.coins += bonusCoins(num: playerModel.logons+1)
            playerModel.logons += 1
        }
        // Alert on app open announces the bonus coins
        .alert(isPresented: $welcomeAlert) {
            Alert(
                title: Text("Welcome back, \(playerModel.username)!"),
                message: Text("This is your \(numberWorder(num: playerModel.logons)) time on DynoTODO. Take this \(bonusCalc(num: playerModel.logons))reward of \(bonusCoins(num: playerModel.logons)) coins!"),
                dismissButton: .default(Text("Thanks!"), action: {})
            )
        }
        // Fix for crashing found here:
        // https://stackoverflow.com/questions/62969859/swiftui-randomly-crashes-on-presentationmode-wrappedvalue-dismiss
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


// Model for the player: the todos that they have made, coins, inventory, and selected options
class PlayerModel: ObservableObject {
    @Published var cards: [Card] {
        didSet {
            let encoder = JSONEncoder()
            UserDefaults.standard.set(try? encoder.encode(cards), forKey: "cards")
        }
    }
    
    @Published var coins: Int {
        didSet {
            let encoder2 = JSONEncoder()
            UserDefaults.standard.set(try? encoder2.encode(coins), forKey: "coins")
        }
    }
    
    @Published var inv: [ShopItem] {
        didSet {
            let encoder3 = JSONEncoder()
            UserDefaults.standard.set(try? encoder3.encode(inv), forKey: "inv")
        }
    }
    
    @Published var username: String {
        didSet {
            let encoder4 = JSONEncoder()
            UserDefaults.standard.set(try? encoder4.encode(username), forKey: "username")
        }
    }
    
    @Published var showPopups: Bool {
        didSet {
            let encoder5 = JSONEncoder()
            UserDefaults.standard.set(try? encoder5.encode(showPopups), forKey: "pop")
        }
    }
    
    @Published var myColor: [Int] {
        didSet {
            let encoder6 = JSONEncoder()
            UserDefaults.standard.set(try? encoder6.encode(myColor), forKey: "color")
        }
    }
    
    @Published var logons: Int {
        didSet {
            let encoder7 = JSONEncoder()
            UserDefaults.standard.set(try? encoder7.encode(logons), forKey: "logons")
        }
    }
    
    init(cards: [Card], coins: Int, inv: [ShopItem], username: String, showPopups: Bool, myColor: [Int], logons: Int) {
        let decoder = JSONDecoder()
        
        if let data = UserDefaults.standard.object(forKey: "cards") as? Data,
           let loadedCards = try? decoder.decode([Card].self, from: data)
        {
            self.cards = loadedCards
        } else {
            self.cards = cards
        }
        
        if let data2 = UserDefaults.standard.object(forKey: "coins") as? Data,
           let loadedCoins = try? decoder.decode(Int.self, from: data2)
        {
            self.coins = loadedCoins
        } else {
            self.coins = coins
        }
        
        if let data3 = UserDefaults.standard.object(forKey: "inv") as? Data,
           let loadedInv = try? decoder.decode([ShopItem].self, from: data3)
        {
            self.inv = loadedInv
        } else {
            self.inv = inv
        }
        
        if let data4 = UserDefaults.standard.object(forKey: "username") as? Data,
           let loadedUsername = try? decoder.decode(String.self, from: data4)
        {
            self.username = loadedUsername
        } else {
            self.username = username
        }
        
        if let data5 = UserDefaults.standard.object(forKey: "pop") as? Data,
           let loadedPopups = try? decoder.decode(Bool.self, from: data5)
        {
            self.showPopups = loadedPopups
        } else {
            self.showPopups = showPopups
        }
        
        if let data6 = UserDefaults.standard.object(forKey: "color") as? Data,
           let loadedColor = try? decoder.decode([Int].self, from: data6)
        {
            self.myColor = loadedColor
        } else {
            self.myColor = myColor
        }
        
        if let data7 = UserDefaults.standard.object(forKey: "logons") as? Data,
           let loadedLogons = try? decoder.decode(Int.self, from: data7)
        {
            self.logons = loadedLogons
        } else {
            self.logons = logons
        }
    }
}

// Default shop items -- default because the items are set to unbought
var defaultShop = [
    ShopItem(name: "Color Tan", cost: 0, red: 255, green: 214, blue: 89),
    ShopItem(name: "Color Blue", cost: 200, red: 0, green: 0, blue: 255),
    ShopItem(name: "Color Green", cost: 500, red: 25, green: 230, blue: 73),
    ShopItem(name: "Color Purple", cost: 500, red: 132, green: 22, blue: 168),
    ShopItem(name: "Color Pink", cost: 750, red: 203, green: 103, blue: 207),
    ShopItem(name: "Color Orange", cost: 1000, red: 255, green: 150, blue: 0),
    ShopItem(name: "Color Red", cost: 2000, red: 255, green: 0, blue: 0),
    ShopItem(name: "Pet Dog", cost: 1000, desc:
             "Man's best friend."
             ),
    ShopItem(name: "Pet Monkey", cost: 2000, desc:
             "Everybody's favorite wacky companion."
             ),
    ShopItem(name: "Pet Horse", cost: 5000, desc:
             "Get from A to B a little faster."
             ),
    ShopItem(name: "Pet Giant", cost: 10000, desc:
             "Travel on his shoulders."
             ),
    ShopItem(name: "Pet Dragon", cost: 100000, desc:
             "Nobody will mess with you now."
             ),
    ShopItem(name: "Hut", cost: 1000, desc:
             "An honest living."
             ),
    ShopItem(name: "Shed", cost: 5000, desc:
             "A little dusty, but at least it's not your parent's basement."
             ),
    ShopItem(name: "Garage", cost: 20000, desc:
             "Spacious and relaxing... when there's no car parked."
             ),
    ShopItem(name: "Apartment", cost: 30000, desc:
             "Your first place. It's easy to get settled, but beware of the high rent."
             ),
    ShopItem(name: "House", cost: 50000, desc:
             "Your first property. You sit on a comfortable couch after a long day, reading a nice book."
             ),
    ShopItem(name: "Mansion", cost: 100000, desc:
             "Victorian-styled and definitely not haunted. Moonlight shines through tall windows and reflects off of old paintings."
             ),
    ShopItem(name: "Estate", cost: 200000, desc:
             "Welcome to the upper echelons of society. Stone walls and marble stairs hum an expensive vibration."
             ),
    ShopItem(name: "Castle", cost: 500000, desc:
             "Useful for defending against invaders. You watch your serfs at work from a balcony up high. It's a little lonely; your footsteps echo against the empty halls."
             ),
    ShopItem(name: "Village", cost: 750000, desc:
             "Your own small town; people live and work on your land. As mayor, you deal with their problems personally. It's tiring, but a respectable position."
             ),
    ShopItem(name: "Fief", cost: 1000000, desc:
             "Greetings, my lord. There is a massive stretch of land which bears your name. Your people are happy and you treat them well."
             ),
    ShopItem(name: "Region", cost: 1500000, desc:
             "Only cost a small fortune."
             ),
    ShopItem(name: "Kingdom", cost: 2000000, desc:
             "A mighty kingdom! Its story will be retold for thousands of years."
             ),
    ShopItem(name: "Empire", cost: 2500000, desc:
             "You lean over your terrace, admiring the view. Kingdoms conquered, enemies vanquished, you have become emperor of all the eye can see. Now you may rest."
             )
]

// Function that turns the playermodel color values (array of ints) into a color
func colorinator(carray: [Int]) -> Color {
    return Color(red: Double(CGFloat(carray[0])/255), green: Double(CGFloat(carray[1])/255), blue: Double(CGFloat(carray[2])/255))
}

// turns numbers into a form that can say 1st, 2nd, 3rd, etc
func numberWorder(num: Int) -> String {
    if String(num) == "11" || String(num) == "12" || String(num) == "13" {
        return "\(num)th"
    }
    if String(num).suffix(1) == "1" {
        return "\(num)st"
    }
    if String(num).suffix(1) == "2" {
        return "\(num)nd"
    }
    if String(num).suffix(1) == "3" {
        return "\(num)rd"
    } else {
        return "\(num)th"
    }
}

// gives announces bonus coins
func bonusCalc(num: Int) -> String {
    if num % 5 == 0 {
        return "bonus "
    } else {
        return ""
    }
}

// gives bonus coins for 5, 10, 50, etc. logins
func bonusCoins(num: Int) -> Int {
    var runningCount = 1
    
    if num % 5 == 0 {
        runningCount += 1
    }
    if num % 10 == 0 {
        runningCount += 2
    }
    if num % 50 == 0 {
        runningCount += 3
    }
    if num % 100 == 0 {
        runningCount += 4
    }
    return 500*runningCount
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
