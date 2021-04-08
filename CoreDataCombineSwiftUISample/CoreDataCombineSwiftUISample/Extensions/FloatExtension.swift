//
//  FloatExtension.swift
//  CoreDataCombineSwiftUISample
//
//  Created by Ankit Thakur on 06/04/21.
//

import Foundation

extension Float {
    func durationStringFromSeconds() -> String {
        let inSeconds = Int(self)
        let seconds = inSeconds % 60
        let minutes = (inSeconds / 60) % 60
        let hours = (inSeconds / 3600)
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format: "%02d:%02d", minutes, seconds)
        } else if seconds > 0 {
            return String(format: "00:%02d", seconds)
        }
        return "00:00"
    }
}
