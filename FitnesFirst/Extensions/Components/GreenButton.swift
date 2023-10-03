//
//  GreenButton.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 20.09.2023.
//

import UIKit

class GreenButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String){
        self.init(type: .system)
        setTitle(text, for: .normal)
        
        configure()
    }
    
    private func configure() {
        backgroundColor = .specialGreen
        layer.cornerRadius = 10
        titleLabel?.font = .robotoBold16()
        tintColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
}
