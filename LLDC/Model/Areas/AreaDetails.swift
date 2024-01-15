//
//  AreaDetails.swift
//  LLDC
//
//  Created by Emojiios on 29/05/2022.
//

import Foundation

class AreaDetails {

    var title:String?
    var about:String?
    var openingHoursFrom:String?
    var openingHoursTo:String?
    var coverPhotoPath:String?
    var rate:Double?
    
    var location:Location?
    var topCall = [TopCall]()
    var utilitie = [Utilitie]()
    
    init(dictionary:[String:Any]) {
        coverPhotoPath = dictionary["coverPhotoPath"] as? String
        title = dictionary["title"] as? String
        about = dictionary["about"] as? String
        
        openingHoursFrom = dictionary["openingHoursFrom"] as? String
        openingHoursTo = dictionary["openingHoursTo"] as? String
        rate = dictionary["rate"] as? Double

        if let Loc = dictionary["location"] as? [String:Any] {
        location = Location(dictionary: Loc)
        }
        
        if let Call = dictionary["topCall"] as? [[String:Any]] {
        for item in Call {
        topCall.append(TopCall(dictionary: item))
        }
        }
        
        if let Util = dictionary["utilitie"] as? [[String:Any]] {
        for item in Util {
        utilitie.append(Utilitie(dictionary: item))
        }
        }
    }
    
}


class Location {
    var address:String?
    var lat:Double?
    var long:Double?
    
    init(dictionary:[String:Any]) {
    address = dictionary["address"] as? String
    lat = dictionary["lat"] as? Double
    long = dictionary["long"] as? Double
    }
}

class TopCall {
    var id:String?
    var title:String?
    var coverPhotoPath:String?
    var screenId:Int?
    var screenName:String?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
    screenId = dictionary["screenId"] as? Int
    screenName = dictionary["screenName"] as? String
    coverPhotoPath = dictionary["coverPhotoPath"] as? String
    }
}


class Utilitie {
    var id:Int?
    var title:String?
    var rate:Double?
    var body:String?
    var coverPhotoPath:String?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? Int
    title = dictionary["title"] as? String
    body = dictionary["body"] as? String
    rate = dictionary["rate"] as? Double
    coverPhotoPath = dictionary["coverPhotoPath"] as? String
    }
}


