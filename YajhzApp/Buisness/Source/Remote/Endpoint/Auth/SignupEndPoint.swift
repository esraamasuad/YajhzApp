//
//  SignupEndPoint.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import Foundation

struct SignupEndPoint: Endpoint {
    var urlPrefix: String = ""
    var service: EndpointService = .signup
    var method: EndpointMethod = .post
    var encoding: EndpointEncoding = .json
    //    var auth: AuthorizationHandler = NoneAuthorizationHandler()
    var parameters: [String: Any] = [:]
    var headers: [String: String] = [:]
    
    init(request: SignupRequest) {
        parameters["email"] = request.email
        parameters["password"] = request.password
        parameters["phone"] = request.phone
        parameters["name"] = request.name
        parameters["device_token"] = request.device_token
    }
}

// MARK: - UserRequest
struct SignupRequest: Codable {
    let name, email, phone, password, device_token: String
}

