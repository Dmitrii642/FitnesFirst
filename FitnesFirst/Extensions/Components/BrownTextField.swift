//
//  BrownTextField.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 19.09.2023.
//

import UIKit

protocol BrownTextFieldProtocol: AnyObject {
    func typing(range: NSRange, replacementString string: String)
    func clear()
}

class BrownTextField: UITextField {
    
    weak var brownDelegate: BrownTextFieldProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        textColor = .specialGray
        font = .robotoBold20()
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        leftViewMode = .always
        clearButtonMode = .always
        returnKeyType = .done
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension BrownTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        brownDelegate?.typing(range: range, replacementString: string)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        brownDelegate?.clear()
        return true
    }
    
}
