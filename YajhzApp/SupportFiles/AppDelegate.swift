//
//  AppDelegate.swift
//  it_graduate_new
//
//  Created by Mahmoud Ibaraheim on 6/29/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// init start screen
        window = UIWindow(frame: UIScreen.main.bounds)
        StartScreenRoute(window: window!).decideInitScreen()
        
        /// setlangauge
        setLanguage()
        setupKeyboardStyle()

        return true
    }
    
    func setLanguage(){
        UILabel.appearance().substituteFontName = AppFonts.TTCommons.regular
        UILabel.appearance().substituteFontNameBold = AppFonts.TTCommons.bold
    }
    
    func setupKeyboardStyle() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.overrideKeyboardAppearance = true
        IQKeyboardManager.shared.keyboardAppearance = .dark
        IQKeyboardManager.shared.toolbarTintColor = UIColor.assetColor
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses.append(UIStackView.self)
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        let stackViewAppearance = UIStackView.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        stackViewAppearance.spacing = -10
    }
    
    func printFonts() {
        for familyName in UIFont.familyNames {
            print("\n-- \(familyName) \n")
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print(fontName)
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }

}

