//
//  AppDelegate.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 29/06/23.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else {return false}
        FirebaseApp.configure()
        Auth.auth().languageCode = "es"
        setupIQKeyboard()
        NavigationManager.shared.start(window: window)
        NavigationManager.shared.pushViewController(SplashScreanView())
        return true
    }
    
    private func setupIQKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 50.0
    }
}

