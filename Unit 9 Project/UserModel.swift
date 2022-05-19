//
//  UserModel.swift
//  Unit 9 Project
//
//  Created by Sol Kim on 4/27/22.
//

import SwiftUI

// User object with properties of the user
struct UserItem: Identifiable, Codable {
    var id = UUID()
    var savedSchools: [School]
    var pageShown: Int
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
    
    @Published var currentSearch: String
    
    init(user: UserItem, currentSearch: String) {
        self.currentSearch = currentSearch
        
        if let data = UserDefaults.standard.object(forKey: "userinfo") {
            if let loadedUser = try? JSONDecoder().decode(UserItem.self, from: data as! Data) {
                self.user = loadedUser
                return
           }
        }
        self.user = user
    }
}
