//
//  PlaceDetails.swift
//  LLDC
//
//  Created by Emojiios on 14/06/2022.
//

import Foundation

class PlaceDetails {

    var id:String?
    var screenId:Int?
    var screenName:String?
    var isFavorite:Bool?
    var coverPhotoPath:String?
    var title:String?
    var rate:Double?
    var areaName:String?
    var subUtilitie:String?
    var about:String?
    var openingHoursFrom:String?
    var openingHoursTo:String?
    var startDate:String?
    var bookingFee:Double?
    var bookingSta:Bool?
    
    var Schedule = [PlaceSchedule]()
    var Offers = [PlaceOffers]()
    var Gallery = [PlaceGallery]()
    var Menu = [PlaceMenu]()
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        screenId = dictionary["screenId"] as? Int
        screenName = dictionary["screenName"] as? String
        isFavorite = dictionary["isFavorite"] as? Bool
        coverPhotoPath = dictionary["coverPhotoPath"] as? String
        title = dictionary["title"] as? String
        rate = dictionary["rate"] as? Double
        areaName = dictionary["areaName"] as? String
        subUtilitie = dictionary["subUtilitie"] as? String
        about = dictionary["about"] as? String
        openingHoursFrom = dictionary["openingHoursFrom"] as? String
        openingHoursTo = dictionary["openingHoursTo"] as? String
        startDate = dictionary["startDate"] as? String
        bookingFee = dictionary["bookingFee"] as? Double
        bookingSta = dictionary["startDate"] as? Bool

        if let schedule = dictionary["schedule"] as? [[String:Any]] {
        for item in schedule {
        Schedule.append(PlaceSchedule(dictionary: item))
        }
        }
        
        if let offers = dictionary["offers"] as? [[String:Any]] {
        for item in offers {
        Offers.append(PlaceOffers(dictionary: item))
        }
        }
        
        if let gallery = dictionary["gallery"] as? [[String:Any]] {
        for item in gallery {
        Gallery.append(PlaceGallery(dictionary: item))
        }
        }
        
        if let menu = dictionary["menu"] as? [[String:Any]] {
        for item in menu {
        Menu.append(PlaceMenu(dictionary: item))
        }
        }
    }
}

struct PlaceSchedule {

    var id:String?
    var startDate:String?
    var openingHoursFrom:String?
    var openingHoursTo:String?
    var bookingFee:Double?
    var availableTickets:Int?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    startDate = dictionary["startDate"] as? String
        
    openingHoursFrom = dictionary["openingHoursFrom"] as? String
    openingHoursTo = dictionary["openingHoursTo"] as? String
    
    bookingFee = dictionary["bookingFee"] as? Double
    availableTickets = dictionary["availableTickets"] as? Int
    }
    
    init(id:String = "",startDate:String = "",From:String = "",To:String = "",bookingFee:Double = 0.0,availableTickets:Int = 0) {
    self.id = id
    self.startDate = startDate
        
    self.openingHoursFrom = From
    self.openingHoursTo = To
    
    self.bookingFee = bookingFee
    self.availableTickets = availableTickets
    }
    
}

struct BookEvents {
    var DaysSelect : PlaceSchedule?
    var ProfileData : Profile?
    var Family : [FamilyMembers]?
    var MembersId : [FamilyMember]?
    var Guests : [GuestsSelected]?
    var GuestsId : [String]?
}

struct Events : Codable {
    var scheduleid = String()
    var familyMember = [[String:String]]()
    var guests = [[String:String]]()
}

class PlaceGallery {

    var mediaType:String?
    var mediaPath:String?
    
    init(dictionary:[String:Any]) {
    mediaType = dictionary["mediaType"] as? String
    mediaPath = dictionary["mediaPath"] as? String
    }
}


class PlaceMenu {

    var menuCategoryId:Int?
    var menuCategory:String?
    var Details = [PlaceMenuDetails]()
    
    init(dictionary:[String:Any]) {
    menuCategoryId = dictionary["menuCategoryId"] as? Int
    menuCategory = dictionary["menuCategory"] as? String
        
    if let details = dictionary["details"] as? [[String:Any]] {
    for item in details {
    Details.append(PlaceMenuDetails(dictionary: item))
    }
    }
    }
}

class PlaceMenuDetails {

    var photoPath:String?
    var price:Double?
    var title:String?
    var about:String?
    
    init(dictionary:[String:Any]) {
        photoPath = dictionary["photoPath"] as? String
        price = dictionary["price"] as? Double
        title = dictionary["title"] as? String
        about = dictionary["about"] as? String
    }
}

class PlaceOffers {

    var id:Int?
    var coverPhotoPath:String?
    var title:String?
    var about:String?
    var expiryDate:String?
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? Int
    coverPhotoPath = dictionary["coverPhotoPath"] as? String
    title = dictionary["title"] as? String
    about = dictionary["about"] as? String
    expiryDate = dictionary["expiryDate"] as? String
    }
}


class PlaceReviews {
    
    var Rate:Int?
    var ProfileImg:String?
    var FullName:String?
    var Comment:String?
    var CreatedIn:String?
    
    init(dictionary:[String:Any]) {
    Rate = dictionary["Rate"] as? Int
    ProfileImg = dictionary["ProfileImg"] as? String
    FullName = dictionary["FullName"] as? String
    Comment = dictionary["Comment"] as? String
    CreatedIn = dictionary["CreatedIn"] as? String
    }
}
