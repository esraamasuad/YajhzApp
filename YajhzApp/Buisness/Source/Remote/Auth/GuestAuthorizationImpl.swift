//
//  GuestAuthorization.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/14/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//


import Foundation
import Promises

class NoneAuthorizationHandler: AuthorizationHandler {

    func setClientManually(clientType: String) {}
    func setUidManually(uid: String) {}
    func setAuthManually(authToken: String) {}
    var tokenHeader: [String: String] = [:]
    var clientHeader: [String: String] = [:]
    var uidHeader: [String: String] = [:]
    func removeAuthManually(authToken: String){}
    func removeClientManually(client: String){}
    func removeUidManually(uid: String){}
}
