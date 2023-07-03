//
//  AlertManager.swift
//  Prueba
//
//  Created by Dsi Soporte Tecnico on 03/07/23.
//

import Foundation
import UIKit

class AlertManager{
    
    private init(){()}
    
    static func showAlert(title: String, message: String, butttons:[String], completionHandler: ((Int) -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, titulo) in butttons.enumerated() {
            let action = UIAlertAction(title: titulo, style: .default) {
                _ in
                completionHandler?(index)
            }
            alertController.addAction(action)
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.windows.last?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        
    }
}
