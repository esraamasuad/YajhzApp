//
//  SignupVM.swift
//  RecipeSearch
//
//  Created by Esraa on 15/11/2023.
//  Copyright © 2023 MahmoudOrganization. All rights reserved.
//

import Bond

class SignupVM: BaseVM {
    private var routingManeger: RouterManager
    private var authRepo: AuthRepo =  AuthRepoImplement()
    private var userRepo: UserRepo = UserRepoImpl()
    private var userAuthoriationHandler: AuthorizationHandler = UserAuthoriationHandler()

    var name: Observable<String?> = Observable("")
    var email: Observable<String?> = Observable("")
    var phone: Observable<String?> = Observable("")
    var password: Observable<String?> = Observable("")
    var confirmPassword: Observable<String?> = Observable("")

    var checkValid: DynamicObjects<Bool> = DynamicObjects(false)
    var signupFire: DynamicObjects<Bool> = DynamicObjects(false)
    var readyForObserve: DynamicObjects<Bool> = DynamicObjects(false)
    
    init(routingManeger: RouterManager) {
        self.routingManeger = routingManeger
    }
    
    override func hydrate() {
        bindToTextChanges()
    }
    
     func bindToTextChanges() {
        [email,name, phone, confirmPassword, password].forEach {  response in
            response.observeNext { item in
                guard  self.readyForObserve.value else {
                    return
                }
                self.signupFire.value = false
                self.checkValid.value = true
            }
        }
    }
    
    func routeToSignin() {
        routingManeger.popBack()
//        let signinView = SigninView(nibName: "SigninView", bundle: nil)
//        routingManeger.push(vc: signinView)
    }
    
    private func routeToHome(_ user: UserProfileModel){
        self.userRepo.userModel = user
        self.userRepo.userLoggedIn = true
        self.userAuthoriationHandler.setAuthManually(authToken: user.token ?? "")
        StartScreenRoute().decideInitScreen()
    }
    
    func signUpEndPoint() {
        showHudLoading()
        authRepo.signUp(request: SignupRequest(name: name.value!, email: email.value!, phone: phone.value!, password: password.value!, device_token: AppConstatnts.deviceUID)).then { (result) in
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
