//
//  LoginPhoneView.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 03/07/23.
//

import UIKit

protocol LoginPhoneProtocol:AnyObject{
    func loginAction(phone: String)
    func activationCodeAction(code: String)
}

protocol LoginPhoneViewProtocol{
    func valideCode()
}
class LoginPhoneView: UIView, LoginPhoneViewProtocol {

    weak var delegate : LoginPhoneProtocol?
    var messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.95)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 28, weight: .bold)
        lbl.numberOfLines = 0
        lbl.text = "Start with your phone number"
        return lbl
    }()
    var phoneLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.95)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.text = "Phone number without +52"
        return lbl
    }()
    var phoneBox: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.layer.borderColor = UIColor.black.withAlphaComponent(0.95).cgColor
        txt.layer.borderWidth = 2
        txt.layer.cornerRadius = 8
        txt.placeholder = "Input your phone number"
        txt.keyboardType = .asciiCapableNumberPad
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 46))
        txt.leftViewMode = .always
        return txt
    }()
    
    var validationCodeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.95)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.text = "SMS Code recive"
        lbl.isHidden = true
        return lbl
    }()
    var validationCodeBox: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.layer.borderColor = UIColor.black.withAlphaComponent(0.95).cgColor
        txt.layer.borderWidth = 2
        txt.layer.cornerRadius = 8
        txt.placeholder = "Input your sms code recived"
        txt.keyboardType = .asciiCapableNumberPad
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 46))
        txt.leftViewMode = .always
        txt.isHidden = true
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
    
    init(delegate: LoginPhoneProtocol) {
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
        addSubview(phoneLabel)
        addSubview(phoneBox)
        addSubview(validationCodeLabel)
        addSubview(validationCodeBox)
        addSubview(continueButton)
    }
    
    private func buildConstraints(){
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            messageLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            messageLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            phoneLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 50),
            phoneLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            phoneLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            phoneBox.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5),
            phoneBox.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            phoneBox.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            phoneBox.heightAnchor.constraint(equalToConstant: 46),
            
            validationCodeLabel.topAnchor.constraint(equalTo: phoneBox.bottomAnchor, constant: 30),
            validationCodeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            validationCodeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            validationCodeBox.topAnchor.constraint(equalTo: validationCodeLabel.bottomAnchor, constant: 5),
            validationCodeBox.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            validationCodeBox.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            validationCodeBox.heightAnchor.constraint(equalToConstant: 46),
            
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            continueButton.heightAnchor.constraint(equalToConstant: 46)
        ])
    }

    @objc private func continueAction(){
        guard let phoneNoNil = phoneBox.text else{
            return
        }
        delegate?.loginAction(phone: phoneNoNil)
    }
    @objc private func valideCodeAction(){
        guard let codeNoNil = validationCodeBox.text else{
            return
        }
        delegate?.activationCodeAction(code: codeNoNil)
    }

    func valideCode() {
        continueButton.setTitle("Code validation", for: .normal)
        continueButton.removeTarget(self, action: #selector(self.continueAction), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(self.valideCodeAction), for: .touchUpInside)
        phoneBox.isEnabled = false
        validationCodeLabel.isHidden = false
        validationCodeBox.isHidden = false
    }
    
}
