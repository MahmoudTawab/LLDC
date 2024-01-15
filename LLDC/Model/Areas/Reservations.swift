//
//  Reservations.swift
//  LLDC
//
//  Created by Emojiios on 21/06/2022.
//

import Foundation

class Reservations {
    
    var id : String?
    var placesId : String?
    var placeTitle : String?
    var coverPath : String?
    var categoryTitle : String?
    var areasTitel : String?
    var date : String?
    var time : String?
    var canCancel : Bool?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        placesId = dictionary["placesId"] as? String
        placeTitle = dictionary["placeTitle"] as? String

        coverPath = dictionary["coverPath"] as? String
        categoryTitle = dictionary["categoryTitle"] as? String
        areasTitel = dictionary["areasTitel"] as? String
        
        date = dictionary["date"] as? String
        time = dictionary["time"] as? String
        canCancel = dictionary["canCancel"] as? Bool
    }
}


class ReservationsDetails {
        
    var id : String?
    var coverPath : String?
    var placeName : String?
    var areaName : String?
    var date : String?
    var time : String?
    
    var note : String?
    var canCancel : Bool?
    var totalBookingFees : Double?
    
    var reservation = [Reservation]()
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        coverPath = dictionary["coverPath"] as? String
        placeName = dictionary["placeName"] as? String
        areaName = dictionary["areaName"] as? String
        date = dictionary["date"] as? String
        time = dictionary["time"] as? String
        totalBookingFees = dictionary["totalBookingFees"] as? Double
        note = dictionary["note"] as? String
        canCancel = dictionary["canCancel"] as? Bool
        
        if let Data = dictionary["reservation"] as? [[String:Any]] {
        for item in Data {
        reservation.append(Reservation(dictionary: item))
        }
        }
    }
}

class Reservation {
        
    var id : String?
    var profile : String?
    var fullName : String?
    var qrPath : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        profile = dictionary["profile"] as? String
        fullName = dictionary["fullName"] as? String
        qrPath = dictionary["qrPath"] as? String
    }
}
