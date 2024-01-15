//
//  MapPlaces.swift
//  LLDC
//
//  Created by Emojiios on 18/05/2022.
//

import Foundation

class MapPlaces {
    
    var id : String?
    var iconPath : String?
    var title : String?
    var areaName : String?
    var openingHoursFrom : String?
    var openingHoursTo : String?
    var Info : locationInfo?
    var screenId : Int?
    var screenName : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        title = dictionary["title"] as? String
        screenId = dictionary["screenId"] as? Int
        screenName = dictionary["screenName"] as? String
        iconPath = dictionary["iconPath"] as? String
        areaName = dictionary["areaName"] as? String
        openingHoursFrom = dictionary["openingHoursFrom"] as? String
        openingHoursTo = dictionary["openingHoursTo"] as? String
        
        if let info = dictionary["locationInfo"] as? [String:Any] {
        Info = locationInfo(dictionary: info)
        }
    }
}


class locationInfo {
    
    var lat : Double?
    var long : Double?
    var address : String?
    var mapIcon : String?
    
    init(dictionary:[String:Any]) {
    lat = dictionary["lat"] as? Double
    long = dictionary["long"] as? Double
    address = dictionary["address"] as? String
    mapIcon = dictionary["mapIcon"] as? String
    }
}
