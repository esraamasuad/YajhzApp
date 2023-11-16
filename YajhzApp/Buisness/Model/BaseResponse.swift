//
//  BaseResponse.swift
//  RecipeSearch
//
//  Created by Esraa on 09/06/2022.
//  Copyright © 2022 MahmoudOrganization. All rights reserved.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
     let success: Bool?
     let response_code: Int?
     let message: String?
     let data: T?
}
