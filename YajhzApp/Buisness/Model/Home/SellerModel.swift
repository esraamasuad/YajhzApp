//
//  SellerModel.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import Foundation

// MARK: - DataClass
struct SellerModel: Codable {
    var data: [SellerDetailsModel]?
    var pagination: Pagination?
}

// MARK: - Datum
struct SellerDetailsModel: Codable {
    var id: Int?
    var name, email, phone: String?
    var image: String?
    var logo: String?
    var description: String?
    var distance: String?
    var type, status: Int?
    var lat, lng, address, appointments: String?
    var trending, popular: Int?
    var rate: String?
    var isFavorite: Bool?
    var categories: [CategoryDetailsModel]?
    var token: String?
    var information: Information?
    var productCategories: [CategoryDetailsModel]?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, image, logo, description, distance, type, status, lat, lng, address, appointments, trending, popular, rate
        case isFavorite = "is_favorite"
        case categories, token, information
        case productCategories = "product_categories"
    }
}

// MARK: - Information
struct Information: Codable {
    var id: Int?
    var identityNumber, taxRecord: String?
    var nationality: String?
    var vehicleImage, vehicleTabletImage, vehicleRegistration, drivingImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case identityNumber = "identity_number"
        case taxRecord = "tax_record"
        case nationality
        case vehicleImage = "vehicle_image"
        case vehicleTabletImage = "vehicle_tablet_image"
        case vehicleRegistration = "vehicle_registration"
        case drivingImage = "driving_image"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    var total, count, perPage, currentPage: Int?
    var totalPages: Int?
    var isPagination: Bool?

    enum CodingKeys: String, CodingKey {
        case total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case isPagination = "is_pagination"
    }
}
