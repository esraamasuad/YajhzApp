//
//  AuthRepo.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/15/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Promises

protocol AuthRepo {
    func signIn(request: SigninRequest) -> Promise<BaseResponse<UserProfileModel>>
    func signUp(request: SignupRequest) -> Promise<BaseResponse<UserProfileModel>>
}
