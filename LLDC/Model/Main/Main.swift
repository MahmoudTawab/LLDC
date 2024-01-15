//
//  Main.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 07/12/2021.
//

import Foundation

class Main {
      
    var IsUser : Bool?
    var random : Int?
    var emailUsed : Bool?
    var phoneUsed : Bool?
    var profile : Profile?
    var mainScreen : MainScreen?
    
    
    init(dictionary:[String:Any]) {
       
    IsUser = dictionary["isUser"] as? Bool
        
    random = dictionary["random"] as? Int
        
    emailUsed = dictionary["emailUsed"] as? Bool
        
    phoneUsed = dictionary["phoneUsed"] as? Bool
        
    ///
    if let main = dictionary["mainScreen"] as? [String:Any]  {
    mainScreen = MainScreen(dictionary: main)
    }

    if let Jwt = dictionary["jwt"] as? String {
    defaults.set(Jwt, forKey: "jwt")
    defaults.synchronize()
    }
        
    ///
    if let UserData = dictionary["profile"] as? [String:Any]  {
    profile = Profile(dictionary: UserData)
    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: UserData)
    defaults.set(encodedData, forKey: "profile")
    defaults.synchronize()
    }
        
    }


}
