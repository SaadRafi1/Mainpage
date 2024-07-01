//
//  UserDefaultManager.swift
//  Mainpage
//
//  Created by o9tech on 26/06/2024.
//

import Foundation

// MARK: - Keys
extension UserDefaultManager{
    enum Key {
        static let username = "username"
        static let email = "Email"
        static let password = "password"
        static let isLoggedIn = "isLoggedin"
    }
}
// MARK: - UserDefaultManager
class UserDefaultManager {
    static let shared = UserDefaultManager()
    private init() {}
    // MARK: - username
    var username: String{
        get {
            return UserDefaults.standard.string(forKey: Key.username) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.username)
        }
    }
    // MARK: - email
    var email: String{
        get {
            return UserDefaults.standard.string(forKey: Key.email) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.email)
        }
    }
    // MARK: - password
    var password: String {
        get {
            return UserDefaults.standard.string(forKey: Key.password) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.password)
        }
    }
    
    var isLoggedIn: Bool{
        get{
            return UserDefaults.standard.bool(forKey: Key.isLoggedIn)
        }
        set{
            return UserDefaults.standard.setValue(newValue, forKey: Key.isLoggedIn)
        }
    }
}

