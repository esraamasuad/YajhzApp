//
//  Auth.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/15/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Promises

class AuthRepoImplement: AuthRepo {

    private var network: NetworkService
    
    init(network: NetworkService = NetworkServiceImpl()) {
        self.network = network
    }

    func signIn(request: SigninRequest) -> Promise<BaseResponse<UserProfileModel>> {
        return self.network.callModel(BaseResponse<UserProfileModel>.self, endpoint: SigninEndPoint(request: request))
    }

    func signUp(request: SignupRequest) -> Promise<BaseResponse<UserProfileModel>> {
        return self.network.callModel(BaseResponse<UserProfileModel>.self, endpoint: SignupEndPoint(request: request))
    }

}
