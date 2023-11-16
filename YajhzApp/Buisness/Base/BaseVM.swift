//
//  BasePresenter.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/15/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation
import FCAlertView

class BaseVM {
    
    init() {
        hydrate()
    }
    
    func hydrate() {}
    
    private var errorMessage: DynamicObjects<String> = DynamicObjects("")
    private var alertMessage: DynamicObjects<String> = DynamicObjects("")
    var isLoading: DynamicObjects<Bool> = DynamicObjects(false)
    var hudLoading: DynamicObjects<Bool> = DynamicObjects(false)

    func showSystemError(error: Error) {
        errorMessage.value = error.localizedDescription
    }
    
    func showErrorAlert(message: String) {
        errorMessage.value = message
    }
    
    func showSystemAlert(alert: String) {
        alertMessage.value = alert
    }

    func implementErrorMessage(_ listener: @escaping (String) -> Void) {
        errorMessage.bind(listener)
    }
    
    func implementAlert(_ listener: @escaping (String) -> Void) {
        alertMessage.bind(listener)
    }
    
    func showHudLoading() {
        hudLoading.value = true
    }
    func showLoading() {
        isLoading.value = true
    }
    
    func hideLoading() {
        isLoading.value = false
    }
    
    func showSigninRequiredAlertMessage() {
        let alert = FCAlertView()
        alert.makeAlertTypeCaution()
        alert.colorScheme = UIColor.assetColor
        alert.dismissOnOutsideTouch = true

        alert.addButton(LocalizedWorlds.cancel.localize) {
            alert.dismiss()
        }

        alert.addButton(LocalizedWorlds.yes.localize) {
        }

        alert.titleFont = UIFont(name: LocalizedWorlds.AppRegularFont.localize, size: 14)
        alert.showAlert(withTitle: LocalizedWorlds.loginRequired.localize, withSubtitle: nil, withCustomImage: nil, withDoneButtonTitle: nil , andButtons: nil)

        alert.secondButtonBackgroundColor = UIColor.assetColor
        alert.secondButtonTitleColor = UIColor.white

        //alert.secondButtonBackgroundColor = UIColor(named: "Background")
        alert.hideDoneButton = true
        alert.autoHideSeconds = 0
        alert.bounceAnimations = false
        alert.animateAlertOutToTop = true
    }
    
}
