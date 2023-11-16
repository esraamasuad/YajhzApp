//
//  CategoryModel.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import Foundation

// MARK: - CategoryModel
struct CategoryModel: Codable {
    var data: [CategoryDetailsModel]?
    var cartCount: Int?

    enum CodingKeys: String, CodingKey {
        case data
        case cartCount = "cart_count"
    }
}

// MARK: - Datum
struct CategoryDetailsModel: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var active: Int?
    var nameAr, nameEn: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image, active
        case nameAr = "name_ar"
        case nameEn = "name_en"
    }
}
