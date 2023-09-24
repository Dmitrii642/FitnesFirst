//
//  NameView.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 19.09.2023.
//

import UIKit

class NameView: UIView {
    
    private let namelabel = UILabel(text: "Name")
    private let nameTextField = BrownTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
        translatesAutoresizingMaskIntoConstraints = false //delete
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupViews() {
        addSubview(namelabel)
        addSubview(nameTextField)
    }
    
    func getNameTextFieldText() -> String {
        guard let text = nameTextField.text else { return "" }
        return text
    }
    
    func deleteTextField() {
        nameTextField.text = ""
    }
    
}

//MARK: - Set Constraints
extension NameView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            namelabel.topAnchor.constraint(equalTo: topAnchor),
            namelabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 7),
            namelabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -7),
            namelabel.heightAnchor.constraint(equalToConstant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: namelabel.bottomAnchor,constant: 3),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
