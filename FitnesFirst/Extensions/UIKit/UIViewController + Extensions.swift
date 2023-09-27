//
//  UIViewController + Extensions.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 24.09.2023.
//

import UIKit

extension UIViewController {
    
    func presentSimpleAlert(title: String, message: String? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okButton)
        
        present(alertController, animated: true)
    }
}
