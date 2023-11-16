//
//  AuthorizationHandler.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/15/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation

import Foundation

protocol AuthorizationHandler {
    var tokenHeader: [String: String] { get }
    var clientHeader: [String: String] { get }
    var uidHeader: [String: String] { get }
    func setAuthManually(authToken: String)
    func setClientManually(clientType: String)
    func setUidManually(uid: String)
    func removeAuthManually(authToken: String)
    func removeClientManually(client: String)
    func removeUidManually(uid: String)
}
