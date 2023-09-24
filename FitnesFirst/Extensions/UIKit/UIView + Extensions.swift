//
//  UIView + Extensions.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 12.09.2023.
//

import UIKit

extension UIView {
    
    func addShadowOnView() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 0.7
        layer.cornerRadius = 1
        
    }
    
}
