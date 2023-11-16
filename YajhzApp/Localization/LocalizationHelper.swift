//
//  LocalizationHelper.swift
//  It_graduate
//
//  Created by Mahmoud Ibaraheim on 6/5/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import UIKit

class Localization {
    /// get current Apple language
    class func currentAppleLanguage() -> String{
        return  (UserDefaults.standard.value(forKey: "AppleLanguage") as? String) ?? "ar"
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        UserDefaults.standard.set(lang, forKey: "AppleLanguage")
        UserDefaults.standard.synchronize()
            if lang != "en" {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
                UITextView.appearance().textAlignment = .right
                UITableView.appearance().semanticContentAttribute = .forceRightToLeft
                UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
                UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
                UIScrollView.appearance().semanticContentAttribute = .forceRightToLeft
             //   UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "AppRegularFont".localize(), size: 15)!], for: .normal)
            }else {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
                UITextView.appearance().textAlignment = .left
                UITableView.appearance().semanticContentAttribute = .forceLeftToRight
                UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
                UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
                UIScrollView.appearance().semanticContentAttribute = .forceLeftToRight
             //   UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "AppRegularFont".localize(), size: 15)!], for: .normal)
            }
        UILabel.appearance().substituteFontName = "AppRegularFont".localize()
        UILabel.appearance().substituteFontNameBold = "AppBoldFont".localize()
    }
    
//    class var isRTL: Bool {
//        return SetLangauge.currentAppleLanguage() == "ar"
//    }
}

//MARK: - String
extension String {
    func localize(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
}

//MARK: - Data
extension Data {
    func toString()-> String{
         return String(decoding: self , as: UTF8.self)
    }
}
