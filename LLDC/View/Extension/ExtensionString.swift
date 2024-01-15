//
//  ExtensionString.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//


import UIKit

extension String {
    
    var localizable:String {
      return NSLocalizedString(self, comment: "")
    }
    
    func TextHeight(_ width: CGFloat, font: UIFont, Spacing:CGFloat) -> CGFloat? {
    let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = Spacing
    let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font,NSAttributedString.Key.paragraphStyle:paragraphStyle], context: nil)
        
    return ceil(boundingBox.height)
    }
    
    func textSizeWithFont(_ font: UIFont) -> CGSize {
    return self.size(withAttributes: [.font: font])
    }
    
    func TextNull() -> Bool {
    if self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 {
    return true
    }
    return false
    }
    
    func Formatter(Format:String = "yyyy-MM-dd'T'HH:mm:ss") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "lang".localizable)
    dateFormatter.dateFormat = Format
    let date = dateFormatter.date(from:self)
    let calendar = NSCalendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour ,.minute ,.second], from: date ?? Date())
    let finalDate = calendar.date(from:components) ?? Date()
    return finalDate
    }
    
    
    public func toInt() -> Int? {
    if let num = NumberFormatter().number(from: self) {
    return num.intValue
    } else {
    return 0
    }
    }


    public func toDouble() -> Double? {
    if let num = NumberFormatter().number(from: self) {
    return num.doubleValue
    } else {
    return 0.0
    }
    }
    
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
    

    var htmlToAttributedString: NSAttributedString? {
    guard let data = data(using: .utf8) else { return nil }
    do {
    return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
    } catch {
    return nil
    }
    }
    
    var htmlToString: String {
    return htmlToAttributedString?.string ?? ""
    }
    
    func hexStringToUIColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
        return UIColor.gray
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
        )
    }
    
    func NumAR() -> String{
        var sum = ""
        let letters = self.map { String($0) }
        for letter in letters {
            if (Int(letter) != nil) {
                let persianNumber = ["۰","۱","۲","۳","٤","٥","٦","۷","۸","۹"]
                sum = sum+persianNumber[Int("\(letter)")!]
            } else {
                sum = sum+letter
            }
        }
        return sum
    }
    
}
