//
//  Int + Extensions.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 21.09.2023.
//

import Foundation

extension Int {
    func  getTimeSeconds() -> String {
        if self / 60 == 0{
            return "\(self % 60) sec"
        }
        if self % 60 == 0 {
            return "\(self / 60) min"
        }
        return "\(self / 60) min \(self % 60) sec"
    }
}
