//
//  LoginViewModel.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 03/07/23.
//

import Foundation
import FirebaseAuth

enum LoginType{
    case Email
    case Phone
}
class LoginViewModel{
   
    private var loginModel: LoginModel
    
    init(loginModel: LoginModel) {
        self.loginModel = loginModel
    }
}

extension LoginViewModel{

    func withEmail(success:@escaping()->Void,
                           failure:@escaping(_ message: String)->Void){
        Auth.auth().signIn(withEmail: loginModel.user, password: loginModel.credential ?? "") { authResult, error in
            guard let _ = authResult else {
                failure(error?.localizedDescription ?? "Correo electrónico y/o contraseña invalidos")
                return
                
            }
            success()
        }
    }
    
    func withPhone(success:@escaping(_ verificationID: String)->Void,
                           failure:@escaping(_ message: String)->Void){
        PhoneAuthProvider.provider().verifyPhoneNumber("+52"+loginModel.user, uiDelegate: nil){ verificationID, error in
            if let error = error {
              failure(error.localizedDescription)
              return
            }
            success(verificationID ?? "")
        }
    }
    
    func valideCode(verificationID: String,
                            verificationCode: String,
                            success:@escaping()->Void,
                            failure:@escaping(_ message: String)->Void){
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential){ authResult, error in
            if let error = error {
                    // Manejar el error al verificar el código de verificación
                failure("\(error.localizedDescription)")
                return
            }
            success()
        }
    }
}
