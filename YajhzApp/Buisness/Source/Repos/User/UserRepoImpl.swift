//
//  UserRepoImpl.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/15/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Promises

class UserRepoImpl: UserRepo {
    
    private var network: NetworkService
    private var localData: LocalData
    
    init(network: NetworkService = NetworkServiceImpl(), localData: LocalData = LocalDataImpl()) {
        self.network = network
        self.localData = localData
    }
    
    var userModel: UserProfileModel? {
        set { localData.set(object: newValue, key: .userModel) }
        get { return  localData.get(object: UserProfileModel.self, key: .userModel) ?? UserProfileModel()}
    }
    
    var userLoggedIn: Bool {
        set { localData.set(newValue, key: .userLoggedIn) }
        get { return (localData.get(key: .userLoggedIn) as? Bool) ?? false}
    }
    
    var userId: Int64 {
        set { localData.set(newValue, key: .userId) }
        get { return (localData.get(key: .userId) as? Int64) ?? 0}
    }
    
    func localLogOut() {
        userModel = nil
        userLoggedIn = false
        localData.removeObject(key: .userId)
        localData.removeObject(key: .userModel)
        localData.removeObject(key: .userLoggedIn)
    }
    
    func getUserProfile() -> Promise<BaseResponse<UserProfileModel>> {
        return self.network.callModel(BaseResponse<UserProfileModel>.self, endpoint: UserProfileEndPoint())
    }

}
