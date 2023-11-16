//
//  SettingsVM.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import Bond

class SettingsVM: BaseVM {
    private var routingManeger: RouterManager
    private var userRepo: UserRepo = UserRepoImpl()
    private var userAuthoriationHandler: AuthorizationHandler = UserAuthoriationHandler()
    
    init(routingManeger: RouterManager) {
        self.routingManeger = routingManeger
    }
    
    override func hydrate() {
    }
    
    func logout(){
        self.userRepo.localLogOut()
        self.userAuthoriationHandler.removeAuthManually(authToken: "")
        StartScreenRoute().decideInitScreen()
    }    
}
