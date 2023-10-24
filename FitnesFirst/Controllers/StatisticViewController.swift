//
//  StatisticViewController.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 17.09.2023.
//

import UIKit

class StatisticViewController: UIViewController {
    
    private let statisticLabel: UILabel = {
        let label = UILabel()
        label.text = "STATISTICS"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Week", "Month"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .specialGreen
        segmentedControl.selectedSegmentTintColor = .specialYellow
        let font = UIFont.robotoMedium16()
        segmentedControl.setTitleTextAttributes([.font : font as Any,
                                                 .foregroundColor: UIColor.white],
                                                for: .normal)
        segmentedControl.setTitleTextAttributes([.font: font as Any,
                                                 .foregroundColor: UIColor.specialGray],
                                                for: .selected)
        segmentedControl.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
        
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private let nameTextField = BrownTextField()
    private let exerciesLabel = UILabel(text: "Exercises")
    private let tableView = StatisticsTableView()
    
    private var differenceArray = [DifferenceWorkout]()
    private var filtredArray = [DifferenceWorkout]()
    private var isFiltred = false
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        segmentedChange()
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(statisticLabel)
        view.addSubview(segmentedControl)
        nameTextField.brownDelegate = self
        view.addSubview(nameTextField)
        view.addSubview(exerciesLabel)
        view.addSubview(tableView)
    }
    
    @objc private func segmentedChange() {
        print(segmentedControl.selectedSegmentIndex)
        let dateToday = Date()
        differenceArray = [DifferenceWorkout]()
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let dateStart = dateToday.offsetDay(days: 7)
            getDifferenceModel(dateStrat: dateStart)
        } else {
            let dateStart = dateToday.offsetMonth(month: 1)
            getDifferenceModel(dateStrat: dateStart)
        }
        tableView.setDifferenceArray(differenceArray)
        tableView.reloadData()
    }
    
    private func getWorkoutName() -> [String] {
        var nameArray = [String]()
        
        let allWorkouts = RealmManager.shared.getResultWorkoutModel()
        
        for workoutModel in allWorkouts {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    private func getDifferenceModel(dateStrat: Date) {
        let dateEnd = Date()
        let nameArray = getWorkoutName()
        let allWorkouts = RealmManager.shared.getResultWorkoutModel()
        
        for name in nameArray {
            let predicate = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStrat, dateEnd])
            let filtredArray = allWorkouts.filter(predicate).sorted(byKeyPath: "workoutDate").map { $0 }
            
            guard let last = filtredArray.last?.workoutReps,
                  let first = filtredArray.first?.workoutReps else {
                return
            }
            let differenceWorkout = DifferenceWorkout(name: name, lastReps: last, firstReps: first)
            differenceArray.append(differenceWorkout)
        }
    }
    
    func filtringWorkouts(text: String) {
        for workout in differenceArray {
            if workout.name.lowercased().contains(text.lowercased()) {
                filtredArray.append(workout)
            }
        }
    }
    
}

//MARK: - BrownTextFieldProtocol
extension StatisticViewController: BrownTextFieldProtocol {
    func typing(range: NSRange, replacementString: String) {
        if let text = nameTextField.text,
           let textRange = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: textRange, with: replacementString)
            
            filtredArray = [DifferenceWorkout]()
            isFiltred = updateText.count > 0
            filtringWorkouts(text: updateText)
        }
        
        if isFiltred {
            tableView.setDifferenceArray(filtredArray)
        } else {
            tableView.setDifferenceArray(differenceArray)
        }
        tableView.reloadData()
    }
    
    func clear() {
        isFiltred = false
        differenceArray = [DifferenceWorkout]()
        
        if segmentedControl.selectedSegmentIndex == 0 {
            getDifferenceModel(dateStrat: Date().offsetDay(days: 7))
            tableView.setDifferenceArray(differenceArray)
            tableView.reloadData()
        } else {
            getDifferenceModel(dateStrat: Date().offsetDay(days: 30))
            tableView.setDifferenceArray(differenceArray)
            tableView.reloadData()
        }
        
    }
}
    
//MARK: - Set Constraints
extension StatisticViewController {
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            statisticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            statisticLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: statisticLabel.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 38),
            
            exerciesLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            exerciesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exerciesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),

            tableView.topAnchor.constraint(equalTo: exerciesLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}

