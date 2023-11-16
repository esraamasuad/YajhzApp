//
//  HomeCategoriesEndPoint.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import Foundation

struct HomeCategoriesEndPoint: Endpoint {
    var urlPrefix: String = ""
    var service: EndpointService = .homeCategories
    var method: EndpointMethod = .get
    var encoding: EndpointEncoding = .query
    var auth: AuthorizationHandler = UserAuthoriationHandler()
    var parameters: [String: Any] = [:]
    var headers: [String: String] = [:]

    init() {}
}

