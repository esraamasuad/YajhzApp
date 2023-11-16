//
//  SigninEndPoint.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import Foundation

struct SigninEndPoint: Endpoint {
    var urlPrefix: String = ""
    var service: EndpointService = .login
    var method: EndpointMethod = .post
    var encoding: EndpointEncoding = .json
    //    var auth: AuthorizationHandler = NoneAuthorizationHandler()
    var parameters: [String: Any] = [:]
    var headers: [String: String] = [:]
    
    init(request: SigninRequest) {
        parameters["email"] = request.email
        parameters["password"] = request.password
        parameters["device_token"] = request.device_token
    }
}

// MARK: - UserRequest
struct SigninRequest: Codable {
    let email, password, device_token: String
}
