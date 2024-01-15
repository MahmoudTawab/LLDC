//
//  PlacesCategories.swift
//  LLDC
//
//  Created by Emojiios on 01/06/2022.
//

import UIKit
import Foundation

class PlacesCategories {
    
    var places = [Places]()
    var utilitie = [Utilitie]()
    init(dictionary:[String:Any]) {
        
        if let Util = dictionary["places"] as? [[String:Any]] {
        for item in Util {
        places.append(Places(dictionary: item))
        }
        }
        
        if let Util = dictionary["utilitie"] as? [[String:Any]] {
        for item in Util {
        utilitie.append(Utilitie(dictionary: item))
        }
        }
    }
}

class Places {
    var id : String?
    var coverPhotoPath : String?
    var placeName : String?
    var rate : Double?
    var areaIcon : String?
    var areaId : Int?
    var areaName : String?
    var utilitieId : Int?
    var utilitieName : String?
    var openingHoursIcon : String?
    var startDate : String?
    var openingHoursFrom : String?
    var openingHoursTo : String?
    var isFavorite:Bool?

    var screenId : Int?
    var screenName : String?
    var subUtilitieId : Int?
    var subUtilitieName : String?
    var placeDescription : String?
    var Rate : RatePlaces?

    init(dictionary:[String:Any]) {
        
        id = dictionary["id"] as? String
        coverPhotoPath = dictionary["coverPhotoPath"] as? String
        placeName = dictionary["placeName"] as? String
        rate = dictionary["rate"] as? Double
        areaIcon = dictionary["areaIcon"] as? String
        areaId = dictionary["areaId"] as? Int
        areaName = dictionary["areaName"] as? String
        utilitieId = dictionary["utilitieId"] as? Int
        utilitieName = dictionary["utilitieName"] as? String
        openingHoursIcon = dictionary["openingHoursIcon"] as? String
        
        startDate = dictionary["startDate"] as? String
        openingHoursFrom = dictionary["openingHoursFrom"] as? String
        openingHoursTo = dictionary["openingHoursTo"] as? String
        
        screenId = dictionary["screenId"] as? Int
        isFavorite = dictionary["isFavorite"] as? Bool
        screenName = dictionary["screenName"] as? String
        subUtilitieId = dictionary["subUtilitieId"] as? Int
        subUtilitieName = dictionary["subUtilitieName"] as? String
        placeDescription = dictionary["placeDescription"] as? String
        
        if let rate = dictionary["ratePlaces"] as? [String:Any] {
        Rate = RatePlaces(dictionary: rate)
        }
    }
}


class RatePlaces {
    var id : String?
    var yourExperience : Int?
    var organization : Int?
    var rat : Int?
    var comment : String?
    var canEdit : Bool?

    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        yourExperience = dictionary["yourExperience"] as? Int
        organization = dictionary["organization"] as? Int
        rat = dictionary["rat"] as? Int
        comment = dictionary["comment"] as? String
        canEdit = dictionary["canEdit"] as? Bool
    }
}
