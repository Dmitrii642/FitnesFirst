//
//  WorkoutModel.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 21.09.2023.
//

import Foundation
import RealmSwift

class WorkoutModel: Object {
    @Persisted var workoutDate: Date
    @Persisted var workoutNumberOfDay: Int = 0
    @Persisted var workoutName: String = ""
    @Persisted var workoutRepeat: Bool = true
    @Persisted var workoutSets: Int = 0
    @Persisted var workoutReps: Int = 0
    @Persisted var workoutTimer: Int = 0            // in seconds
    @Persisted var workoutImage: Data?
    @Persisted var workoutStatus: Bool = false
}
