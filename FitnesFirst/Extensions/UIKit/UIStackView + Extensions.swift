//
//  UIStackView + Extensions.swift
//  MyFirstApp_31.08.
//
//  Created by Дмитрий Яковлев on 07.09.2023.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
