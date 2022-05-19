//
//  ModelLayer.swift
//  Unit 7 Project
//
//  Created by Sol Kim on 2/28/22.
//

import SwiftUI

// User object with properties of the user
struct UserItem: Identifiable, Codable {
    var id = UUID()
    var numerator: Int
    var denominator: Int
    var bpm: Int
    var sound: String
    var flashcolor: [Int]
    var subdivision: Double
}

// Model layer of usermodel user object
class UserModel: ObservableObject {
    @Published var user: UserItem {
        didSet {
            if let encoded = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(encoded, forKey: "userinfo")
            }
        }
    }
    
    init(user: UserItem) {
        if let data = UserDefaults.standard.object(forKey: "userinfo") {
            if let loadedUser = try? JSONDecoder().decode(UserItem.self, from: data as! Data) {
                self.user = loadedUser
                return
           }
        }
        self.user = user
    }
}
