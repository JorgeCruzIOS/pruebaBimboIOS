//
//  LoadingManager.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 03/07/23.
//

import Foundation
import UIKit
import Lottie

class LoadingManager{
    static let shared = LoadingManager()
    private var loading : LoadingView?
    private init(){
        self.loading = LoadingView()
    }
    
    func showLoading(){
        guard let loading = loading else{
            return
        }
        UIApplication.shared.windows.last?.rootViewController?.present(loading, animated: false)
    }
    func dismissLoading(){
        loading?.dismiss(animated: false)
    }
}

fileprivate class LoadingView: UIViewController{
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
        view.backgroundColor = .black.withAlphaComponent(0.6)
        view.addSubview(lottiLoader)
        NSLayoutConstraint.activate([
            lottiLoader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lottiLoader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottiLoader.heightAnchor.constraint(equalToConstant: 600),
        ])
    }
}
