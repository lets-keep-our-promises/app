//
//  TimeFormatter.swift
//  Els
//
//  Created by 박성민 on 10/9/24.
//

import Foundation

class TimeFormatter {
    static func formattedtime(from time: Double) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        return String(format: "%02dH %02dM", hours, minutes)
    }
}
