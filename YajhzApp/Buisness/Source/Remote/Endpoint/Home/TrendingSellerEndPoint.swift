//
//  TrendingSellerEndPoint.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import Foundation

struct TrendingSellerEndPoint: Endpoint {
    var urlPrefix: String = ""
    var service: EndpointService = .trending
    var method: EndpointMethod = .get
    var encoding: EndpointEncoding = .query
    var auth: AuthorizationHandler = NoneAuthorizationHandler()
    var parameters: [String: Any] = [:]
    var headers: [String: String] = [:]

    init() {}
}
