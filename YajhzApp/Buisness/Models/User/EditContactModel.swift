//
//  EditContactModel.swift
//  chappme
//
//  Created by Ahmed on 9/21/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation


// MARK: - DataClass
struct EditContactModel: Codable {
    let id: Int?
    let firstName, lastName, country, countryCode: String?
    let phone, birthdate: String?
    let profileImg, idNationalFrontImg, idNationalBackImg: String?
    let chappmeID, currency: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case country
        case countryCode = "country_code"
        case phone, birthdate
        case profileImg = "profile_img"
        case idNationalFrontImg = "id_national_front_img"
        case idNationalBackImg = "id_national_back_img"
        case chappmeID = "chappme_id"
        case currency
    }
}
