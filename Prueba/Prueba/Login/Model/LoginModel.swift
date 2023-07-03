//
//  Login.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 03/07/23.
//

import Foundation

struct LoginModel{
    let user: String
    var credential: String?
    var typo: LoginType = .Email
    
    init(user: String, credential: String? = nil, typo: LoginType) {
        self.user = user
        self.credential = credential
        self.typo = typo
    }
}
