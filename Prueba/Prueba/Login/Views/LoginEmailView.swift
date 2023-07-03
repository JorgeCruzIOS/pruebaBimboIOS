//
//  LoginEmailView.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 03/07/23.
//

import UIKit

protocol LoginEmailProtocol:AnyObject{
    func loginAction(email: String, credential: String)
}

class LoginEmailView: UIView {
    weak var delegate: LoginEmailProtocol?
    var messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.95)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 28, weight: .bold)
        lbl.numberOfLines = 0
        lbl.text = "Start with your email and password"
        return lbl
    }()
    var emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.95)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.text = "Email"
        return lbl
    }()
    var emailBox: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.layer.borderColor = UIColor.black.withAlphaComponent(0.95).cgColor
        txt.layer.borderWidth = 2
        txt.layer.cornerRadius = 8
        txt.placeholder = "Input your email"
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 46))
        txt.leftViewMode = .always
        return txt
    }()
    var credentiaLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.95)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.text = "Password"
        return lbl
    }()
    var credentialBox: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.layer.borderColor = UIColor.black.withAlphaComponent(0.95).cgColor
        txt.layer.borderWidth = 2
        txt.layer.cornerRadius = 8
        txt.placeholder =  "Input your password"
        txt.isSecureTextEntry = true
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 46))
        txt.leftViewMode = .always
        return txt
    }()
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.95), for: .normal)
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.95).cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.continueAction), for: .touchUpInside)
        return button
    }()
    init(delegate: LoginEmailProtocol) {
        super.init(frame: CGRect.zero)
        self.delegate = delegate
        buildUI()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI(){
        backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 240/255, alpha: 1)
        addSubview(messageLabel)
        addSubview(emailLabel)
        addSubview(emailBox)
        addSubview(credentiaLabel)
        addSubview(credentialBox)
        addSubview(continueButton)
    }
    
    private func buildConstraints(){
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            messageLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            messageLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            emailLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 50),
            emailLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            emailLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            emailBox.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            emailBox.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            emailBox.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            emailBox.heightAnchor.constraint(equalToConstant: 46),
            
            credentiaLabel.topAnchor.constraint(equalTo: emailBox.bottomAnchor, constant: 30),
            credentiaLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            credentiaLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            credentialBox.topAnchor.constraint(equalTo: credentiaLabel.bottomAnchor, constant: 5),
            credentialBox.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            credentialBox.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            credentialBox.heightAnchor.constraint(equalToConstant: 46),
            
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            continueButton.heightAnchor.constraint(equalToConstant: 46)
        ])
    }

    @objc private func continueAction(){
        guard let emailNoNil = emailBox.text, let credentialNoNil = credentialBox.text else{
            return
        }
        delegate?.loginAction(email: emailNoNil, credential: credentialNoNil)
    }
}
