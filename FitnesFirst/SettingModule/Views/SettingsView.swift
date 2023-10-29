//
//  SettingsView.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 07.10.2023.
//

import UIKit

class SettingsView: UIView {
    
    private let firstNameLabel = UILabel(text: "First name")
    let firstNameTextField = BrownTextField()
    
    private let secondNameLabel = UILabel(text: "Second name")
     let secondNameTextField = BrownTextField()
    
    private let heightLabel = UILabel(text: "Height")
     let heightTextField = BrownTextField()
    
    private let weightLabel = UILabel(text: "Weight")
     let weightTextField = BrownTextField()
    
    private let targetLabel = UILabel(text: "Target")
    let targetTextField = BrownTextField()
    
    
    private lazy var firstNameStackView = UIStackView(arrangedSubviews: [firstNameLabel, firstNameTextField],
                                                      axis: .vertical,
                                                      spacing: 3)
    private lazy var secondNameStackView = UIStackView(arrangedSubviews: [secondNameLabel, secondNameTextField],
                                                       axis: .vertical,
                                                       spacing: 3)
    private lazy var heightStackView = UIStackView(arrangedSubviews: [heightLabel, heightTextField],
                                                   axis: .vertical,
                                                   spacing: 3)
    private lazy var weightStackView = UIStackView(arrangedSubviews: [weightLabel, weightTextField],
                                                   axis: .vertical,
                                                   spacing: 3)
    private lazy var targetStackView = UIStackView(arrangedSubviews: [targetLabel, targetTextField],
                                                   axis: .vertical,
                                                       spacing: 3)
    private lazy var generalStackView = UIStackView(arrangedSubviews: [firstNameStackView,
                                                                       secondNameStackView,
                                                                       heightStackView,
                                                                       weightStackView,
                                                                      targetStackView],
                                                    axis: .vertical,
                                                    spacing: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(generalStackView)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Set Constraints
extension SettingsView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            firstNameTextField.heightAnchor.constraint(equalToConstant: 40),
            secondNameTextField.heightAnchor.constraint(equalToConstant: 40),
            heightTextField.heightAnchor.constraint(equalToConstant: 40),
            weightTextField.heightAnchor.constraint(equalToConstant: 40),
            targetTextField.heightAnchor.constraint(equalToConstant: 40),
            
            generalStackView.topAnchor.constraint(equalTo: topAnchor),
            generalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            generalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            generalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
