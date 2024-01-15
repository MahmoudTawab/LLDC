//
//  SignUpInfo.swift
//  LLDC
//
//  Created by Emojiios on 25/04/2022.
//

import UIKit

class SignUpInfo {
      
    var city = [City]()
    var Marketing = [MarketingChannel]()
    init(dictionary:[String:Any]) {
    for item in dictionary["city"] as? [[String:Any]] ?? [[String:Any]()] {
    city.append(City(dictionary: item))
    }
        
    for item in dictionary["marketingChannel"] as? [[String:Any]] ?? [[String:Any]()] {
    Marketing.append(MarketingChannel(dictionary: item))
    }
    }
}

class City {
      
   var id : Int?
   var name : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
    }
}

class MarketingChannel {
      
    var id : Int?
    var Channel : String?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? Int
    Channel = dictionary["channel"] as? String
    }
}




