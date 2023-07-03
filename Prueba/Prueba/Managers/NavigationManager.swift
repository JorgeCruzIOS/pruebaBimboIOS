//
//  NavigationManager.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 02/07/23.
//

import Foundation
import UIKit

class NavigationManager{
    static let shared = NavigationManager()
    private let navigation =  UINavigationController()
    
    func start(window: UIWindow){
        navigation.viewControllers.removeAll()
        navigation.navigationBar.tintColor = .white
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigation.navigationBar.barStyle = .black
        window.rootViewController = navigation
        window.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    
    func pushViewController(_ to: UIViewController){
        guard navigation.viewControllers.count != 0 else{
            navigation.pushViewController(to, animated: true)
            return
        }
        navigation.viewControllers.last?.navigationController?.pushViewController(to, animated: true)
    }
    
    func presentViewController(_ to: UIViewController){
        navigation.viewControllers.last?.present(to, animated: true)
    }
    
}

public extension UIViewController{
   
    func hideKeyboardWhenTappedAround() {
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
