//
//  BaseView.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/15/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD
import SwiftMessages
import SkeletonView

class BaseView<ViewModel: BaseVM, Item: BaseItem>: UIViewController {
    let frame = UIScreen.main.bounds
    var item: Item!
    let hud = JGProgressHUD(style: .dark)
    
    var viewModel: ViewModel! {
        didSet {
            viewModel.implementAlert { (alert) in
                self.showAlertMessage(title: "", message: alert, theme: .success)
            }
            
            viewModel.implementErrorMessage { (error) in
                self.showAlertMessage(title: "", message: error, theme: .error)
            }
            
            viewModel.isLoading.bind { (loading) in
                if loading {
                    self.showLoading()
                } else {
                    self.hideLoading()
                }
            }
            viewModel.hudLoading.bind { (loading) in
                if loading {
                    self.showHudLoading()
                } else {
                    self.hideLoading()
                }
            }
        }
    }
        
   public func puplicAlert(title: String, message: String, theme: Theme){
        self.showAlertMessage(title: "", message: message, theme: theme)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem?.title = ""
    }
     
    func showLoading() {
        self.view.showAnimatedGradientSkeleton()
    }
    func showHudLoading() {
        self.hud.show(in: self.view)
    }
    
    func hideLoading(){
        self.view.hideSkeleton()
        self.hud.dismiss()
    }

    func bindind() {}
}

extension BaseView {

    private func showAlertMessage(title: String, message: String, theme: Theme) {
        let success = MessageView.viewFromNib(layout: .messageView)
        success.configureTheme(theme)
        success.configureDropShadow()
        success.configureContent(title: title, body: message)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.dimMode = .blur(style: .dark, alpha: 0.4, interactive: true)
        successConfig.presentationStyle = .top
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: successConfig, view: success)

    }
}
