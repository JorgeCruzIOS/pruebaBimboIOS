//
//  ViewController.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 29/06/23.
//

import UIKit
import Lottie

class SplashScreanView: UIViewController {

    var backgroundImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "splash")
        return img
    }()
    lazy var viewCircular: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "eclipse")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var lottiLoader: AnimationView = {
        let animation = Animation.named("rocketLaunch",
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(backgroundImage)
        view.addSubview(viewCircular)
        view.addSubview(lottiLoader)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            lottiLoader.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            lottiLoader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottiLoader.heightAnchor.constraint(equalToConstant: 600),
            lottiLoader.widthAnchor.constraint(equalToConstant: 600),
            viewCircular.centerXAnchor.constraint(equalTo: lottiLoader.centerXAnchor),
            viewCircular.centerYAnchor.constraint(equalTo: lottiLoader.centerYAnchor,constant: -100),
            viewCircular.heightAnchor.constraint(equalToConstant: 200),
            viewCircular.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            NavigationManager.shared.pushViewController(LoginController())
        })
    }

}

