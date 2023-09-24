//
//  DateAndRepeatView.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 20.09.2023.
//

import UIKit

class DateAndRepeatView: UIView {
    
    private let dateAndRepeatLabel = UILabel(text: "Date and repeat")
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel = UILabel(text: "Date",
                                    font: .robotoMedium18(),
                                    textColor: .specialGray)
    private let repeatLabel = UILabel(text: "Repeat every 7 days",
                                      font: .robotoMedium18(),
                                      textColor: .specialGray)
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .specialGreen
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.onTintColor = .specialGreen

        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    private lazy var dateStackView = UIStackView(arrangedSubviews: [dateLabel, datePicker],
                                            axis: .horizontal,
                                            spacing: 10)
    private lazy var repeatStackView = UIStackView(arrangedSubviews: [repeatLabel, repeatSwitch],
                                                   axis: .horizontal,
                                                   spacing: 10)
    private lazy var unitStackView = UIStackView(arrangedSubviews: [dateStackView, repeatStackView],
                                                 axis: .vertical,
                                                 spacing: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
//        datePicker.setFirstWeekdayToMonday()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        dateStackView.distribution = .equalSpacing
        repeatStackView.distribution = .equalSpacing
        
        addSubview(dateAndRepeatLabel)
        addSubview(backView)
        addSubview(unitStackView)
    }
    
    func getDateAndRepeat() -> (data: Date, isRepeat: Bool) {
        (datePicker.date, repeatSwitch.isOn)
    }
    
    func resetDataAndRepeat() {
        datePicker.date = Date()
        repeatSwitch.isOn = true
    }
    
}

//MARK: - Set Constraints
extension DateAndRepeatView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateAndRepeatLabel.topAnchor.constraint(equalTo: topAnchor,constant: 0),
            dateAndRepeatLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 7),
            dateAndRepeatLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5),
            
            backView.topAnchor.constraint(equalTo: dateAndRepeatLabel.bottomAnchor,constant: 3),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 0),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 0),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 0),
            
            unitStackView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            unitStackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            unitStackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10)
            
        ])
    }
}

////MARK: - Set First Weekday To Monday
//extension UIDatePicker {
//    func setFirstWeekdayToMonday() {
//        if var calendar = self.calendar {
//            calendar.firstWeekday = 2
//            self.calendar = calendar
//        }
//    }
//}
