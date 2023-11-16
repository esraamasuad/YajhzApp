//
//  SignupView.swift
//  RecipeSearch
//
//  Created by Esraa on 15/11/2023.
//  Copyright © 2023 MahmoudOrganization. All rights reserved.
//

import UIKit
import SwiftValidator

class SignupView: BaseView<SignupVM, BaseItem> {
    
    //MARK: - OUTLET
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPaswordTxt: UITextField!

    @IBOutlet weak var userNameErrorLbl: UILabel!
    @IBOutlet weak var passwordErrorLbl: UILabel!
    @IBOutlet weak var confirmPasswordErrorLbl: UILabel!
    @IBOutlet weak var emailErrorLbl: UILabel!
    @IBOutlet weak var phoneErrorLbl: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - DATA
    private let validator = Validator()
    
    //MARK: - LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTransparentNavagtionBar("")

        viewModel = SignupVM(routingManeger: RouterManagerImpl(self))

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
        viewModel.name.bidirectionalBind(to: nameTxt.reactive.text)
        viewModel.phone.bidirectionalBind(to: phoneTxt.reactive.text)
        viewModel.password.bidirectionalBind(to: passwordTxt.reactive.text)
        viewModel.confirmPassword.bidirectionalBind(to: confirmPaswordTxt.reactive.text)
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
    
        [emailTxt, nameTxt, phoneTxt, passwordTxt, confirmPaswordTxt].forEach { txt in
            txt?.delegate = self
        }
    }
}

//MARK: - Actions -

extension SignupView {
    @IBAction func signUpAction(_ sender: UIButton) {
        viewModel.signupFire.value = true
        viewModel.readyForObserve.value = true
        validator.validate(self)
        self.view.endEditing(true)
    }

    @IBAction func LoginAction(_ sender: UIButton) {
        viewModel.routeToSignin()
    }
}

//MARK: -  Validation -

extension SignupView: ValidationDelegate{
    func validationSuccessful() {
        guard viewModel.signupFire.value else {
            return
        }
        viewModel.signUpEndPoint()
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        viewModel.signupFire.value = false
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
                                     rules: [RequiredRule(message: "email is required!"),
                                             EmailRule(message: "email format is invalid!")])
        validator.registerField(nameTxt,
                                errorLabel: userNameErrorLbl,
                                rules: [RequiredRule(message: "name is required!")])
        
        validator.registerField(phoneTxt,
                                errorLabel: phoneErrorLbl,
                                rules: [RequiredRule(message: "phone is required!"),
                                PhoneNumberRule(regex: "^\\d{11}$", message: "phone is invalid!")])
        
        validator.registerField(passwordTxt,
                                errorLabel: passwordErrorLbl,
                                rules: [RequiredRule(message: "password is required!"),
                                MinLengthRule(length: 8, message: "password must be 8 character at least!")])
        
        validator.registerField(confirmPaswordTxt,
                                errorLabel: confirmPasswordErrorLbl,
                                rules: [RequiredRule(message: "confirm password is required!"), ConfirmationRule(confirmField: passwordTxt, message: "password is mismatch!")])
    }
    
}
//MARK: - UITextFieldDelegate -

extension SignupView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.superview?.borderColor = UIColor.assetColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.superview?.borderColor = UIColor.borderColor
    }
    
}
