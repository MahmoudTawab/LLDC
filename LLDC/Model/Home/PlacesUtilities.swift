//
//  PlacesUtilities.swift
//  LLDC
//
//  Created by Emojiios on 09/06/2022.
//

import Foundation

class PlacesUtilities {
    
    var utilitiesInfo : UtilitiesInfo?
    var subUtilities = [Utilitie]()
    var places = [Places]()
    
    init(dictionary:[String:Any]) {
        
        if let Info = dictionary["utilitiesInfo"] as? [String:Any] {
        self.utilitiesInfo = UtilitiesInfo(dictionary: Info)
        }
        
        if let Util = dictionary["subUtilities"] as? [[String:Any]] {
        for item in Util {
        subUtilities.append(Utilitie(dictionary: item))
        }
        }
        
        if let Util = dictionary["places"] as? [[String:Any]] {
        for item in Util {
        places.append(Places(dictionary: item))
        }
        }
    }
}

class UtilitiesInfo {
      
    var id : Int?
    var title : String?
    var coverPhotoPath : String?

    init(dictionary:[String:Any]) {
               
    id = dictionary["id"] as? Int
    title = dictionary["title"] as? String
    coverPhotoPath = dictionary["coverPhotoPath"] as? String
    }

}
