//
//  UserRepo.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/15/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Promises

protocol UserRepo {
    var userModel: UserProfileModel? {get set}
    var userLoggedIn: Bool {get set}
    var userId: Int64 {get set}
    func localLogOut()
    
    func getUserProfile() -> Promise<BaseResponse<UserProfileModel>>
}

