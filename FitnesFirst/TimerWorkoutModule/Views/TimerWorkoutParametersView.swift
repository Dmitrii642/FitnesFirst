//
//  TimerWorkoutParametersView.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 04.10.2023.
//

import UIKit

protocol NextSetTimerProtocol: AnyObject {
    func nextSetTimerTapped()
    func editingTimerTapped()
}

class TimerWorkoutParametersView: UIView {
    
    weak var cellNextTimerDeligate: NextSetTimerProtocol?
    
    private let workoutNameLabel = UILabel(text: "Name",
                                           font: .robotoMedium24(),
                                           textColor: .specialGray)
    
    private let setsLabel = UILabel(text: "Sets",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    
    private let numberOfSets = UILabel(text: "1/4",
                                       font: .robotoMedium24(),
                                       textColor: .specialGray)
    
    private let setsLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timerLabel = UILabel(text: "Time of set",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    
    private let numberOfTimerLabel = UILabel(text: "20",
                                       font: .robotoMedium24(),
                                       textColor: .specialGray)
    
    private let numberLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "editing")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("Editing", for: .normal)
        button.tintColor = .specialLightBrown
        button.titleLabel?.font = .robotoBold16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextSetsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("Next Set", for: .normal)
        button.tintColor = .specialGray
        button.titleLabel?.font = .robotoBold16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextSetsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var repsStackView = UIStackView()
    var setsStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(workoutNameLabel)
        workoutNameLabel.textAlignment = .center
        
        setsStackView = UIStackView(arrangedSubviews: [setsLabel, numberOfSets],
                                    axis: .horizontal,
                                    spacing: 10)
        setsStackView.distribution = .equalSpacing
        addSubview(setsStackView)
        addSubview(setsLineView)
        
        numberOfTimerLabel.textAlignment = .right
        repsStackView = UIStackView(arrangedSubviews: [timerLabel, numberOfTimerLabel],
                                   axis: .horizontal,
                                   spacing: 10)
        repsStackView.distribution = .equalSpacing
        addSubview(repsStackView)
        addSubview(numberLineView)
        addSubview(editingButton)
        addSubview(nextSetsButton)
    }
    
    @objc private func editingButtonTapped() {
        cellNextTimerDeligate?.editingTimerTapped()
    }
    
    @objc private func nextSetsButtonTapped() {
        cellNextTimerDeligate?.nextSetTimerTapped()
    }
    
    func refreshLabel(model: WorkoutModel, numberOfSet: Int) {
        workoutNameLabel.text = model.workoutName
        numberOfSets.text = "\(numberOfSet)/\(model.workoutSets)"
        numberOfTimerLabel.text = "\(model.workoutTimer.getTimeSeconds())"
    }
    
//    func buttonsIsEnable() {
//        editingButton.isEnabled = !editingButton.isEnabled
//        nextSetsButton.isEnabled = !nextSetsButton.isEnabled
//    }
    
    func buttonsIsEnable(_ value: Bool) {
            editingButton.isEnabled = value
            nextSetsButton.isEnabled = value
        }
    
}

//MARK: - Set Constraints
extension TimerWorkoutParametersView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            workoutNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            workoutNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            workoutNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            setsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 10),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            setsStackView.heightAnchor.constraint(equalToConstant: 25),

            setsLineView.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 2),
            setsLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            setsLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            setsLineView.heightAnchor.constraint(equalToConstant: 1),
   
            repsStackView.topAnchor.constraint(equalTo: setsLineView.bottomAnchor, constant: 20),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            repsStackView.heightAnchor.constraint(equalToConstant: 25),
 
            numberLineView.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 2),
            numberLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            numberLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            numberLineView.heightAnchor.constraint(equalToConstant: 1),
   
            editingButton.topAnchor.constraint(equalTo: numberLineView.bottomAnchor, constant: 10),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            editingButton.heightAnchor.constraint(equalToConstant: 20),
            editingButton.widthAnchor.constraint(equalToConstant: 80),
 
            nextSetsButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 10),
            nextSetsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextSetsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextSetsButton.heightAnchor.constraint(equalToConstant: 45)
            
            
        ])
    }
}
