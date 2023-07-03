//
//  LoginView.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 03/07/23.
//

import UIKit
import Lottie

class LoginView: UIView {
    lazy var lottiLoader: AnimationView = {
        let animation = Animation.named("loginLaunch",
                                        bundle: .main,
                                        subdirectory: nil,
                                        animationCache: nil)

        let lottie = AnimationView(animation: animation)
        lottie.contentMode = .scaleAspectFit
        lottie.backgroundBehavior = .pauseAndRestore
        lottie.loopMode = .loop
        lottie.play()
        lottie.translatesAutoresizingMaskIntoConstraints = false
        return lottie
    }()
    lazy var messageTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.95)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "Welcome Explorer!"
        return lbl
    }()
    lazy var submessageTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.85)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 20, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "Start your mission with:"
        return lbl
    }()
    lazy var emailButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("@ Email", for: .normal)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.95), for: .normal)
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.95).cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.loginEmailAction), for: .touchUpInside)
        return button
    }()
    lazy var phoneButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("# Phone number", for: .normal)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.95), for: .normal)
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.95).cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.loginPhoneAction), for: .touchUpInside)
        return button
    }()
    init(){
        super.init(frame: .zero)
        buildUI()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI(){
        backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 240/255, alpha: 1)
        addSubview(lottiLoader)
        addSubview(messageTitle)
        addSubview(submessageTitle)
        addSubview(emailButton)
        addSubview(phoneButton)
    }
    
    private func buildConstraints(){
        NSLayoutConstraint.activate([
            lottiLoader.topAnchor.constraint(equalTo: topAnchor, constant: -60),
            lottiLoader.leadingAnchor.constraint(equalTo: leadingAnchor),
            lottiLoader.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            messageTitle.topAnchor.constraint(equalTo: lottiLoader.bottomAnchor, constant: -100),
            messageTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            submessageTitle.topAnchor.constraint(equalTo: messageTitle.bottomAnchor),
            submessageTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            emailButton.topAnchor.constraint(equalTo: submessageTitle.bottomAnchor, constant: 100),
            emailButton.heightAnchor.constraint(equalToConstant: 50),
            emailButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            emailButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            phoneButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 30),
            phoneButton.heightAnchor.constraint(equalToConstant: 50),
            phoneButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            phoneButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    @objc private func loginEmailAction(){
        NavigationManager.shared.presentViewController(LoginManagerController(logintype: .Email))
    }
    
    @objc private func loginPhoneAction(){
        NavigationManager.shared.presentViewController(LoginManagerController(logintype: .Phone))
    }
}
