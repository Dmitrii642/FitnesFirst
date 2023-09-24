//
//  Date + Extensions.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 21.09.2023.
//

import Foundation

extension Date {
    func getWeekdayNumber() -> Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: self)
        return  weekday
    }
    
    func localDate() -> Date {
        let timeZoneOffSet = TimeZone.current.secondsFromGMT(for: self)
        let localDate = Calendar.current.date(byAdding: .second, value: timeZoneOffSet, to: self) ?? Date()
        return localDate
    }
    
    func getWeekArray() -> [[String]] {
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "en_GB")
        formater.dateFormat = "EEEEEE"
        let calendar = Calendar.current
        
        var weekArray:[[String]] = [[], []]
        
        for index in -6...0 {
            let date = calendar.date(byAdding: .day, value: index, to: self) ?? Date()
            let day = calendar.component(.day, from: date)
            weekArray[1].append("\(day)")
            let weekday = formater.string(from: date)
            weekArray[0].append(weekday)
        }
        return weekArray
    }
    
    func offsetDay(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -days, to: self) ?? Date()
    }
}

