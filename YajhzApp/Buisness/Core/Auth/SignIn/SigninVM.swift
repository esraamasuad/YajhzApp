//
//  SigninVM.swift
//  RecipeSearch
//
//  Created by Esraa on 15/11/2023.
//  Copyright © 2023 MahmoudOrganization. All rights reserved.
//

import Bond

class SigninVM: BaseVM {
    private var routingManeger: RouterManager
    private var authRepo: AuthRepo =  AuthRepoImplement()
    private var userRepo: UserRepo = UserRepoImpl()
    private var userAuthoriationHandler: AuthorizationHandler = UserAuthoriationHandler()

    var email: Observable<String?> = Observable("")
    var password: Observable<String?> = Observable("")
    
    var checkValid: DynamicObjects<Bool> = DynamicObjects(false)
    var loginFire: DynamicObjects<Bool> = DynamicObjects(false)
    var readyForObserve: DynamicObjects<Bool> = DynamicObjects(false)
    
    init(routingManeger: RouterManager) {
        self.routingManeger = routingManeger
    }
    
    override func hydrate() {
        bindToTextChanges()
    }
    
     func bindToTextChanges() {
        [email,password].forEach {  response in
            response.observeNext { item in
                guard  self.readyForObserve.value else {
                    return
                }
                self.loginFire.value = false
                self.checkValid.value = true
            }
        }
    }
    
    func routeToSignUp() {
        let signupView = SignupView(nibName: "SignupView", bundle: nil)
        routingManeger.push(vc: signupView)
    }
    
    private func routeToHome(_ user: UserProfileModel){
        self.userRepo.userModel = user
        self.userRepo.userLoggedIn = true
        self.userAuthoriationHandler.setAuthManually(authToken: user.token ?? "")
        StartScreenRoute().decideInitScreen()
    }
    
    func loginEndPoint() {
        showHudLoading()
        authRepo.signIn(request: SigninRequest(email: email.value!, password: password.value!, device_token: AppConstatnts.deviceUID)).then { (result) in
            guard let code = result.response_code, (code == 200) else{
                self.showErrorAlert(message: result.message ?? "")
                return
            }
            self.routeToHome(result.data!)
        }.catch { (error) in
            self.showSystemError(error: error)
        }.always {
            self.hideLoading()
        }
    }
    
}
