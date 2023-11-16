//
//  UserProfileModel.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import Foundation

// MARK: - DataClass
struct UserProfileModel: Codable {
    var id: Int?
    var name, email, phone: String?
    var image: String?
    var type, status: Int?
    var balance: String?
    var addresses: [AddressDetailsModel]?
    var token: String?
}

// MARK: - Address
struct AddressDetailsModel: Codable {
    var id: Int?
    var lat, lng: String?
    var address: String?
    var street, building, apartment: String?
    var floor, name: String?
}
