//
//  Notifications.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 09/12/2021.
//

import Foundation

class Notifications {
    

    var id : String?
    var readable : Bool?
    var iconPath : String?
    var title : String?
    var details : String?
    var createdIn : String?
    
    init(dictionary:[String:Any]) {
       
    id = dictionary["id"] as? String
    iconPath = dictionary["iconPath"] as? String
    readable = dictionary["readable"] as? Bool
        
    title = dictionary["title"] as? String
    details = dictionary["details"] as? String
    createdIn = dictionary["createdIn"] as? String
    }
}
