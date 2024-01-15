//
//  ExtensionDate.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit
import Foundation

extension Date {
    
    func timeAgo() -> String {
    let secondsAgo = abs(Int(Date().timeIntervalSince(self)))

    let minute = 60
    let hour = 60 * minute
    let day = 24 * hour

    let quotient: Int
    let unit: String
    if secondsAgo < minute {
    quotient = secondsAgo
    unit = "second".localizable
    return "\(quotient) \(unit)\(quotient == 1 ? "" : "s".localizable) \("ago".localizable)"
    } else if secondsAgo < hour {
    quotient = secondsAgo / minute
    unit = "min".localizable
    return "\(quotient) \(unit)\(quotient == 1 ? "" : "s".localizable) \("ago".localizable)"

    } else if secondsAgo < day {
    quotient = secondsAgo / hour
    unit = "hour".localizable
    return "\(quotient) \(unit)\(quotient == 1 ? "" : "s".localizable) \("ago".localizable)"

    } else {
    return self.Formatter("yyyy-MM-dd hh:mm a")
    }
    }
    
    
func Formatter(_ dateFormat: String = "yyyy-MM-dd") -> String {
let dateFormatter = DateFormatter()
dateFormatter.locale = Locale(identifier: "en")
dateFormatter.dateFormat = dateFormat
let calendar = NSCalendar.current
let components = calendar.dateComponents([.year, .month, .day, .hour ,.minute ,.second], from: self)
let finalDate = calendar.date(from:components) ?? Date()
return dateFormatter.string(from: finalDate)
}

}
