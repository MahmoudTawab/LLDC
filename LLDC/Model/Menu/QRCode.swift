//
//  QRCode.swift
//  LLDC
//
//  Created by Emojiios on 23/06/2022.
//

import Foundation

class QRCode {

    var qrCodePath : String?
    var memberTypeId : Int?
    var memberType : String?
    var iconPath : String?
    var isPlatinium : Bool?
    
    init(dictionary:[String:Any]) {
    qrCodePath = dictionary["qrCodePath"] as? String
    memberTypeId = dictionary["memberTypeId"] as? Int
    memberType = dictionary["memberType"] as? String
    iconPath = dictionary["iconPath"] as? String
    isPlatinium = dictionary["isPlatinium"] as? Bool
    }
}
