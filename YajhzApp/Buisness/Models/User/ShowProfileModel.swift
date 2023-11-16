//
//  showProfile.swift
//  chappme
//
//  Created by Ahmed on 9/22/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation


// MARK: - DataClass
struct ShowProfileModel: Codable {
    let user: User?
    let usersAccounts: [UsersAccount]?

    enum CodingKeys: String, CodingKey {
        case user
        case usersAccounts = "users_accounts"
    }
}

// MARK: - UsersAccount
struct UsersAccount: Codable {
    let id: Int?
    let accountType: String?
    let accountLogo: String?
    let cardHoldNumber, cardNumber, expiryDate: String?
    let cvvCode: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case accountType = "account_type"
        case accountLogo = "account_logo"
        case cardHoldNumber = "card_hold_number"
        case cardNumber = "card_number"
        case expiryDate = "expiry_date"
        case cvvCode = "cvv_code"
    }
}
