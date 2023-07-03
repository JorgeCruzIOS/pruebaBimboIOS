//
//  LoginController.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 03/07/23.
//

import UIKit

class LoginController: UIViewController {

    private var ui : LoginView?
    
    override func loadView() {
        super.loadView()
        self.ui = LoginView()
        self.view = ui
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
}
