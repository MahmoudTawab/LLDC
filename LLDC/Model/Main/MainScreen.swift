//
//  MainScreen.swift
//  LLDC
//
//  Created by Emojiios on 15/05/2022.
//

import Foundation


class MainScreen {
      
    var Categories = [TopCollection]()
    var featuredEvents = [FeaturedEvents]()
    
    var jardins = [Jardins]()
    var shopsOffers = [ShopsOffers]()
    var foodBeverage = [FoodBeverage]()
    var happeningNow = [HappeningNow]()
    var comingSoon = [ComingSoonData]()
    
    init(dictionary:[String:Any]) {
        
    if let Data = dictionary["topCollectionView"] as? [[String:Any]] {
    for item in Data {
    Categories.append(TopCollection(dictionary: item))
    }
    }
        
    if let Data = dictionary["featuredEvents"] as? [[String:Any]] {
    for item in Data {
    featuredEvents.append(FeaturedEvents(dictionary: item))
    }
    }
      
    if let Data = dictionary["jardins"] as? [[String:Any]] {
    for item in Data {
    jardins.append(Jardins(dictionary: item))
    }
    }
            
    if let Data = dictionary["shopsOffers"] as? [[String:Any]] {
    for item in Data {
    shopsOffers.append(ShopsOffers(dictionary: item))
    }
    }
      
    if let Data = dictionary["foodBeverage"] as? [[String:Any]] {
    for item in Data {
    foodBeverage.append(FoodBeverage(dictionary: item))
    }
    }
     
    if let Data = dictionary["happeningNow"] as? [[String:Any]] {
    for item in Data {
    happeningNow.append(HappeningNow(dictionary: item))
    }
    }
                
    if let Data = dictionary["comingSoon"] as? [[String:Any]] {
    for item in Data {
    comingSoon.append(ComingSoonData(dictionary: item))
    }
    }
        
    }

}

class TopCollection {
      
    var id : Int?
    var title : String?
    var iconPath : String?

    init(dictionary:[String:Any]) {
               
    id = dictionary["id"] as? Int
    title = dictionary["title"] as? String
    iconPath = dictionary["iconPath"] as? String
    }

}

class FeaturedEvents {
      
    
    var id : String?
    var title : String?
    var photoPath : String?
    var screenId : Int?
    var screenName : String?

    init(dictionary:[String:Any]) {
       
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
    photoPath = dictionary["photoPath"] as? String
    screenId = dictionary["screenId"] as? Int
    screenName = dictionary["screenName"] as? String
    }

}

class Jardins {
      
    var id : Int?
    var title : String?
    var iconPath : String?
    var background : String?

    init(dictionary:[String:Any]) {
       
    id = dictionary["id"] as? Int
    title = dictionary["title"] as? String
    iconPath = dictionary["iconPath"] as? String
    background = dictionary["background"] as? String
    }

}

class ShopsOffers {
      
    var id : String?
    var title : String?
    var photoPath : String?
    var description : String?
    var screenId : Int?
    var screenName : String?

    init(dictionary:[String:Any]) {
       
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
    photoPath = dictionary["photoPath"] as? String
    description = dictionary["description"] as? String
    screenId = dictionary["screenId"] as? Int
    screenName = dictionary["screenName"] as? String
    }

}

class FoodBeverage {
      
    var id : String?
    var title : String?
    var location : String?
    var photoPath : String?
    var openingHoursFrom : String?
    var openingHoursTo : String?
    var screenId : Int?
    var screenName : String?

    init(dictionary:[String:Any]) {
       
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
    location = dictionary["location"] as? String
    photoPath = dictionary["photoPath"] as? String
    openingHoursFrom = dictionary["openingHoursFrom"] as? String
    openingHoursTo = dictionary["openingHoursTo"] as? String
    screenId = dictionary["screenId"] as? Int
    screenName = dictionary["screenName"] as? String
    }

}

class HappeningNow {
      
    var id : String?
    var title : String?
    var location : String?
    var photoPath : String?
    var screenId : Int?
    var screenName : String?

    init(dictionary:[String:Any]) {
       
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
    photoPath = dictionary["photoPath"] as? String
    location = dictionary["location"] as? String
    screenId = dictionary["screenId"] as? Int
    screenName = dictionary["screenName"] as? String
    }

}

class ComingSoonData {
      
    var id : String?
    var title : String?
    var location : String?
    var startDate : String?
    var startTime : String?
    var photoPath : String?
    var screenId : Int?
    var screenName : String?

    init(dictionary:[String:Any]) {
       
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
    photoPath = dictionary["photoPath"] as? String
    location = dictionary["location"] as? String
    startDate = dictionary["startDate"] as? String
    startTime = dictionary["startTime"] as? String
    screenId = dictionary["screenId"] as? Int
    screenName = dictionary["screenName"] as? String
    }

}

