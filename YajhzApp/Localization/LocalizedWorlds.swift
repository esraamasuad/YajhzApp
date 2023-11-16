//
//  LocalizedWorlds.swift
//  beauty_user
//
//  Created by Mac on 12/8/20.
//  Copyright © 2020 MahmoudOrganization. All rights reserved.
//

import Foundation

enum LocalizedWorlds:String  {
    
    case cancel = "cancel"
    case yes = "yes"
    case ok = "ok"
    case loginRequired = "loginRequired"
    case noData = "noData"
    
    case  AppBoldFont = "AppBoldFont"
    case AppRegularFont = "AppRegularFont"
        
    var localize: String {
        return self.rawValue.localize()
   }
}
