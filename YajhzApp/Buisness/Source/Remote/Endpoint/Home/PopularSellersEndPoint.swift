//
//  PopularSellersEndPoint.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import Foundation

struct PopularSellersEndPoint: Endpoint {
    var urlPrefix: String = ""
    var service: EndpointService = .popular
    var method: EndpointMethod = .get
    var encoding: EndpointEncoding = .query
    var auth: AuthorizationHandler = UserAuthoriationHandler()
    var parameters: [String: Any] = [:]
    var headers: [String: String] = [:]

    init(request: FilterRequest) {
        parameters["lat"] = request.lat
        parameters["lng"] = request.lng
    }
}

// MARK: - UserRequest
struct FilterRequest: Codable {
    let lat, lng: String
}

