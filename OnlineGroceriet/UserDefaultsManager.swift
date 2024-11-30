//
//  UserDefaultsManager.swift
//  OnlineGroceriet
//
//  Created by Engy on 11/29/24.
//

import Foundation
class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let pref = UserDefaults.standard
    var continueAsAGuest: Bool = false
    var isLogin: Bool = false
    var isBoarding:Bool = false
    var darkModeEnabled: Bool = false
    var gender: String = ""
    var name: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var phone: String = ""
    var email: String = ""
    var password: String = ""
    var userId: String = ""
    var wishlistID: Int = 0
    var shoppingCartID: Int = 0
    var exchangeRate:Double = 0
    var currency: String = ""
    var country: String = ""
    var countryFlag: String = ""

    private init(){
        getStoredData()
    }

    func getStoredData(){
        self.continueAsAGuest = getSharedBool(forKey: "guest")
        self.isLogin  = getSharedBool(forKey: "isLogin")
        self.isBoarding  = getSharedBool(forKey: "isBoarding")
        self.darkModeEnabled  = getSharedBool(forKey: "darkMode")
        self.gender = getSharedString(forKey: "gender")
        self.name = getSharedString(forKey: "name")
        self.firstName = getSharedString(forKey: "firstName")
        self.lastName = getSharedString(forKey: "lastName")
        self.phone = getSharedString(forKey: "phone")
        self.email = getSharedString(forKey: "email")
        self.password = getSharedString(forKey: "password")
        self.userId = getSharedString(forKey: "userID")
        self.wishlistID = getSharedInt(forKey: "wishlistID")
        self.shoppingCartID = getSharedInt(forKey: "shoppingCartID")
        self.currency = getSharedString(forKey: "currency")
        self.exchangeRate = getSharedDouble(forKey: "exchangeRate")


        if self.exchangeRate == 0 {
            self.exchangeRate = 1
        }
        if self.currency == "" {
            self.currency = "USD"
        }
    }
    func storeData(){
        setSharedValue("guest", value: continueAsAGuest)
        setSharedValue("isLogin", value: isLogin)
        setSharedValue("isBoarding", value: isBoarding)
        setSharedValue("darkMode",value: darkModeEnabled)
        setSharedValue("gender", value: gender)
        setSharedValue("name", value: name)
        setSharedValue("firstName", value: firstName)
        setSharedValue("lastName", value: lastName)
        setSharedValue("phone", value: phone)
        setSharedValue("email", value: email)
        setSharedValue("password", value: password)
        setSharedValue("userID", value: userId)
        setSharedValue("wishlistID", value: wishlistID)
        setSharedValue("shoppingCartID", value: shoppingCartID)
        setSharedValue("currency", value: currency)

    }
    func logout(){
        removeValue(forKey: "guest")
        removeValue(forKey: "isLogin")
        removeValue(forKey: "darkMode")
        removeValue(forKey: "gender")
        removeValue(forKey: "name")
        removeValue(forKey: "firstName")
        removeValue(forKey: "lastName")
        removeValue(forKey: "phone")
        removeValue(forKey: "email")
        removeValue(forKey: "password")
        removeValue(forKey: "userID")
        removeValue(forKey: "wishlistID")
        removeValue(forKey: "shoppingCartID")
        removeValue(forKey: "currency")
       
//        removeValue(forKey: "isBoarding")
//        clearCache()
        getStoredData()
    }

    private func setSharedValue(_ key: String, value: Any) {
        self.pref.set(value, forKey: key)
    }
    private func getSharedValue(forKey key: String) -> Any? {
        return self.pref.object(forKey: key)
    }
    private func getSharedString(forKey key: String) -> String {
        return self.pref.object(forKey: key) as? String ?? ""
    }

    private func getSharedInt(forKey key: String) -> Int {
        return self.pref.object(forKey: key) as? Int ?? 0
    }
    private func getSharedDouble(forKey key: String) -> Double {
        return self.pref.object(forKey: key) as? Double ?? 0.0
    }

    private func getSharedBool(forKey key: String) -> Bool {
        return self.pref.object(forKey: key) as? Bool ?? false
    }

    private func removeValue(forKey key: String) {
        self.pref.set("", forKey: key)
        self.pref.removeObject(forKey: key)
        self.pref.synchronize()
    }
    private func clearCache() {
        let domain = Bundle.main.bundleIdentifier ?? ""
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
