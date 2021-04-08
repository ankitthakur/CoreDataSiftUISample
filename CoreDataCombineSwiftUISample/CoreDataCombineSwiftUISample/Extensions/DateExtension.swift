//
//  DateExtension.swift
//  CoreDataCombineSwiftUISample
//
//  Created by Ankit Thakur on 06/04/21.
//

import Foundation

extension Date {
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    // Returns yesterday's date object
    func yesterday() -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date().noon)!
    }
    // Returns tommorow's date object
    func tomorrow() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date().noon)!
    }
    
    func dateWithoutTime() -> Date {
        let timeZone = TimeZone.current
        let timeIntervalWithTimeZone = self.timeIntervalSinceReferenceDate + Double(timeZone.secondsFromGMT())
        let timeInterval = floor(timeIntervalWithTimeZone / 86400) * 86400
        return Date(timeIntervalSinceReferenceDate: timeInterval)
    }
    
    func isToday() -> Bool {
        let todayDate = self.dateWithoutTime()
        let currentDate = self.dateWithoutTime()
        if todayDate == currentDate {
            return true
        }
        return false
    }
    
    func isYesterday() -> Bool {
        let yesterdayDate = self.yesterday().dateWithoutTime()
        let currentDate = self.dateWithoutTime()
        if yesterdayDate == currentDate {
            return true
        }
        return false
    }
    
    func timeAgo() -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = self < now ? self : now
        let latest =  self > now ? self : now
        
        let unitFlags: Set<Calendar.Component> = [.minute, .hour]
        let components: DateComponents = calendar.dateComponents(unitFlags, from: earliest, to: latest)
        
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        var minutesString = ""
        if minute > 0 {
            minutesString = String(minute) + (minute > 1 ? "mins" : "min")
        }
        var hoursString = ""
        if hour > 0 {
            hoursString = String(hour) + (hour > 1 ? "hrs" : "hr")
        }
        
        if !hoursString.isEmpty {
            if !minutesString.isEmpty {
                return "\(hoursString) \(minutesString) ago"
            } else {
                return "\(hoursString) ago"
            }
        } else if !minutesString.isEmpty {
            return "\(minutesString) ago"
        }
        return ""
    }
    
}
