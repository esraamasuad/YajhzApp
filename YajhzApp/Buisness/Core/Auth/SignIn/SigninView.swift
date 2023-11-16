//
//  SigninView.swift
//  RecipeSearch
//
//  Created by Esraa on 15/11/2023.
//  Copyright © 2023 MahmoudOrganization. All rights reserved.
//

import UIKit
import SwiftValidator

class SigninView: BaseView<SigninVM, BaseItem> {
    
    //MARK: - OUTLET
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var passwordErrorLbl: UILabel!

    @IBOutlet weak var loginCornerView: UIView!

    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - DATA
    private let validator = Validator()
    
    //MARK: - LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTransparentNavagtionBar("")

        viewModel = SigninVM(routingManeger: RouterManagerImpl(self))

        setupValidation()
        listenToValidation()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - Setup -

    func setUp() {
        // binding
        viewModel.email.bidirectionalBind(to: emailTxt.reactive.text)
        viewModel.password.bidirectionalBind(to: passwordTxt.reactive.text)
        viewModel.checkValid.bind{ _ in
            self.validator.validate(self)
        }
        
        // cornerView
//        loginCornerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        scrollView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        [scrollView].forEach { view in
            view?.layer.cornerRadius = 40
            view?.layer.masksToBounds = true
        }
    
        [emailTxt, passwordTxt].forEach { txt in
            txt?.delegate = self
        }
    }
}

//MARK: - Actions -

extension SigninView {
    
    @IBAction func signUpAction(_ sender: UIButton) {
        viewModel.routeToSignUp()
    }

    @IBAction func LoginAction(_ sender: UIButton) {
        viewModel.loginFire.value = true
        viewModel.readyForObserve.value = true
        validator.validate(self)
        self.view.endEditing(true)
    }

}

//MARK: -  Validation -

extension SigninView: ValidationDelegate{
    func validationSuccessful() {
        guard viewModel.loginFire.value else {
            return
        }
        viewModel.loginEndPoint()
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        viewModel.loginFire.value = false
    }
    
    func listenToValidation(){
        validator.styleTransformers(success:{ (validationRule) -> Void in
            validationRule.errorLabel?.isHidden = true
            validationRule.errorLabel?.text = ""
            if let textField = validationRule.field as? UITextField {
//                textField.superview?.borderWidth = 1.0
                textField.superview?.borderColor = UIColor.borderColor
            }
        }, error:{ (validationError) -> Void in
            validationError.errorLabel?.isHidden = false
            validationError.errorLabel?.text = validationError.errorMessage
            if let textField = validationError.field as? UITextField {
//                textField.superview?.borderWidth = 1.0
                textField.superview?.borderColor = #colorLiteral(red: 0.9607843161, green: 0.1813162923, blue: 0.1141882733, alpha: 1)
            }
        })
    }
    
    func setupValidation(){
        self.validator.registerField(emailTxt,
                                     errorLabel: self.emailErrorLbl,
                                     rules: [RequiredRule(message: "email is required!")])
        validator.registerField(passwordTxt,
                                errorLabel: passwordErrorLbl,
                                rules: [RequiredRule(message: "password is required!")])
    }
    
}
//MARK: - UITextFieldDelegate -

extension SigninView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superview?.borderColor = UIColor.assetColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.superview?.borderColor = UIColor.borderColor
    }
    
}
