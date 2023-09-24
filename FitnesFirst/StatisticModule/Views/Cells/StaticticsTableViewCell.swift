//
//  StaticticsViewCell.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 17.09.2023.
//

import UIKit

class StaticticsTableViewCell: UITableViewCell {
    
    private let backgroundBlackLine: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statisticsNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Biceps"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "+2"
        label.textColor = .specialGreen
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let beforeLabel = UILabel(text: "Before: 18")
    private let nowLabel = UILabel(text: "Now: 20")
    
    private lazy var labelsStackView = UIStackView(arrangedSubviews: [beforeLabel, nowLabel],
                                                     axis: .horizontal,
                                                     spacing: 10)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       setupViews()
       setConstraints() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(labelsStackView)
        addSubview(progressLabel)
        addSubview(statisticsNameLabel)
        addSubview(backgroundBlackLine)
    }
}

//MARK: - Set Constraints
extension StaticticsTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundBlackLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundBlackLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backgroundBlackLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            backgroundBlackLine.heightAnchor.constraint(equalToConstant: 1),
            
            progressLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            progressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            progressLabel.widthAnchor.constraint(equalToConstant: 60),
            
            statisticsNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            statisticsNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            statisticsNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            labelsStackView.topAnchor.constraint(equalTo: statisticsNameLabel.bottomAnchor, constant: 2),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelsStackView.trailingAnchor.constraint(lessThanOrEqualTo: progressLabel.leadingAnchor, constant: -10),
            labelsStackView.bottomAnchor.constraint(equalTo: backgroundBlackLine.topAnchor, constant: -5)
            
            
        ])
    }
}
