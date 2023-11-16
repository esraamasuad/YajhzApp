//
//  ViewsLocalization.swift
//  beauty_user
//
//  Created by Esraa Masuad on 10/18/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation
import UIKit
 
extension UIApplication {
    class func isRTL() -> Bool{
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
}

class SetLocalizer: NSObject {
    class func DoTheMagic() {
        
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        MethodSwizzleGivenClassName(cls: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector(getter: UIApplication.cstm_userInterfaceLayoutDirection))
        MethodSwizzleGivenClassName(cls: UITextField.self, originalSelector: #selector(UITextField.layoutSubviews), overrideSelector: #selector(UITextField.cstmlayoutSubviews))
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))
    }
}


extension UILabel {
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
       
        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) {
            return // handle special case with uitextfields
        }
        
        // for for user bio && counter in addPost
        if self.textAlignment == .center {
            return
        }
        
        if UIApplication.isRTL()  {
            self.textAlignment =  (self.tag >= 0) ? .right : .left
        } else {
            self.textAlignment = (self.tag >= 0) ? .left : .right
        }
       
    }
    
    @objc var substituteFontName : String {
        get { return self.font.fontName }
        set {
            //if self.tag == 5 { return }
            if self.font.fontName.range(of:"-Regular") != nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    
    @objc var substituteFontNameBold : String {
        get { return self.font.fontName }
        set {
            if (self.font.fontName.range(of:"-Bold") != nil) ||
                (self.font.fontName.range(of:"-Black") != nil) ||
                (self.font.fontName.range(of:"-Semibold") != nil) ||
                (self.font.fontName.range(of:"-Medium") != nil) {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
}



extension UITextField {
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        
        if self.font?.fontName.range(of:"-Regular") != nil {
            self.font = UIFont(name: "AppRegularFont".localize(), size: self.font?.pointSize ?? 15)
        }else {
            self.font = UIFont(name: "AppBoldFont".localize(), size: self.font?.pointSize ?? 15)
        }
        if self.textAlignment == .center {
            return
        }
        
        if UIApplication.isRTL()  {
            if self.textAlignment == .right { return }
            self.textAlignment = .right
        } else {
            if self.textAlignment == .left { return }
            self.textAlignment = .left
        }
     }
}

var numberoftimes = 0
extension UIApplication {
    @objc var cstm_userInterfaceLayoutDirection : UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if Localization.currentAppleLanguage() != "en" {
                direction = .rightToLeft
            }
            return direction
        }
    }
}
extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            let currentLanguage = Localization.currentAppleLanguage()
            var bundle = Bundle();
            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            }else
                if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                    bundle = Bundle(path: _path)!
                } else {
                    let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                    bundle = Bundle(path: _path)!
            }
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}

/// Exchange the implementation of two methods of the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}
