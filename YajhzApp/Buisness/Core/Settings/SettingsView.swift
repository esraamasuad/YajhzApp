//
//  SettingsView.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import UIKit

class SettingsView: UIViewController {
    
    var viewModel: SettingsVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SettingsVM(routingManeger: RouterManagerImpl(self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}

//MARK: - Actions -

extension SettingsView {
    
    @IBAction func logoutAction(_ sender: UIButton) {
        viewModel.logout()
    }
    
}

