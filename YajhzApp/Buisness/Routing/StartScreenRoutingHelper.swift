//
//  StartScreenRouting.swift
//  SwiftMVVMStartupProject
//
//  Created by Mahmoud Ibaraheim on 6/14/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation
import UIKit

class StartScreenRoute {
    var userRepo: UserRepo
    var window: UIWindow 
    
    init(window: UIWindow = (UIApplication.shared.delegate?.window)!!  ,userRepo: UserRepo = UserRepoImpl()) {
        self.window = window
        self.userRepo = userRepo
    }
    
    private func routeTo<ViewController: UIViewController>(storyBoard: Storyboard, idintifier: String , controller: ViewController.Type){
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle:nil)
        window.rootViewController =  UINavigationController.init(rootViewController: storyboard.instantiateViewController(withIdentifier: idintifier) as! ViewController)
    }
        
    public func routeToHome() {
        let homeNav = UINavigationController(rootViewController: HomeView(nibName: "HomeView", bundle: nil))
        window.rootViewController = homeNav
        window.makeKeyAndVisible()
    }
    
    public func routeToLogin() {
        let signinNav = UINavigationController(rootViewController: SigninView(nibName: "SigninView", bundle: nil))
        window.rootViewController = signinNav
        window.makeKeyAndVisible()
    }
    
    func decideInitScreen() {
       !UserRepoImpl().userLoggedIn ? routeToLogin() : routeToHome()
    }

}
