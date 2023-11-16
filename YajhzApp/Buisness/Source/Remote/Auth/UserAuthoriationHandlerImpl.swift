//
//  UserAuthoriationHandler.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/14/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//


import Foundation
import KeychainSwift
import Promises

class UserAuthoriationHandler: AuthorizationHandler {
    
    private let keychainKey = "CustomerAuthorizationHandler"
    private let clientKey = "clientAuthoriztionHeader"
    private let uidKey = "uidAuthoriztionHeader"
    private let keychain = KeychainSwift()
    
    init() {
    }
    var lang: [String : String]{
        return ["lang": "en"]//(keychain.get(self.langKey) ?? "")]
    }
    
    var clientHeader: [String: String] {
        return ["user-type": ""]
    }
    
    var uidHeader: [String: String] {
        return ["uid":  (keychain.get(self.uidKey) ?? "")]
    }
    
    var tokenHeader: [String: String] {
        return ["Authorization": "Bearer " + (keychain.get(self.keychainKey) ?? "") ]
    }

    func setAuthManually(authToken: String) {
        self.keychain.set(authToken, forKey: self.keychainKey)
    }
    
    func setClientManually(clientType: String) {
        self.keychain.set(clientType, forKey: self.clientKey)
    }
    
    func setUidManually(uid: String) {
        self.keychain.set(uid, forKey: self.uidKey)
    }
    func removeLang(lang: String) {
        self.keychain.set("", forKey: self.keychainKey)
    }
    
    
    func removeAuthManually(authToken: String) {
        self.keychain.set("", forKey: self.keychainKey)
    }
    
    func removeClientManually(client: String) {
        self.keychain.set("", forKey: self.clientKey)
    }
    
    func removeUidManually(uid: String) {
        self.keychain.set("", forKey: self.uidKey)
    }
    
}
