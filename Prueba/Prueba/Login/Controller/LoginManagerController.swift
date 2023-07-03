//
//  LoginEmailController.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 03/07/23.
//

import UIKit

class LoginManagerController: UIViewController {
    private var loginVM : LoginViewModel?
    private var typeLoginView : LoginType = .Email
    private var verificationID: String = ""
    override func loadView() {
        super.loadView()
        self.view = typeLoginView == .Email ? LoginEmailView(delegate: self) : LoginPhoneView(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Inicio de sesión"
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    init(logintype: LoginType){
        self.typeLoginView = logintype
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginManagerController: LoginEmailProtocol{
    func loginAction(email: String, credential: String) {
        LoadingManager.shared.showLoading()
        loginVM = LoginViewModel(loginModel: LoginModel(user: email, credential: credential, typo: .Email))
        loginVM?.withEmail(success: {
            LoadingManager.shared.dismissLoading()
            self.dismiss(animated: true) {
                NavigationManager.shared.pushViewController(MissionController())
            }
        }, failure: { message in
            LoadingManager.shared.dismissLoading()
            AlertManager.showAlert(title: "Space X", message: message, butttons: ["Ok"], completionHandler: nil)
        })
    }
}
 

extension LoginManagerController: LoginPhoneProtocol{
    func loginAction(phone: String) {
        LoadingManager.shared.showLoading()
        loginVM = LoginViewModel(loginModel: LoginModel(user: phone, typo: .Phone))
        loginVM?.withPhone(success: { verificationID in
            LoadingManager.shared.dismissLoading()
            self.verificationID = verificationID
            (self.view as? LoginPhoneViewProtocol)?.valideCode()
        }, failure: { message in
            LoadingManager.shared.dismissLoading()
            AlertManager.showAlert(title: "Space X", message: message, butttons: ["Ok"], completionHandler: nil)
        })
    }
    
    func activationCodeAction(code: String) {
        LoadingManager.shared.showLoading()
        loginVM?.valideCode(verificationID: self.verificationID, verificationCode: code, success: {
            LoadingManager.shared.dismissLoading()
            self.dismiss(animated: true) {
                NavigationManager.shared.pushViewController(MissionController())
            }
        }, failure: { message in
            LoadingManager.shared.dismissLoading()
            AlertManager.showAlert(title: "Space X", message: message, butttons: ["Ok"], completionHandler: nil)
        })
    }
    
    
}
