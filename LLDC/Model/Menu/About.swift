//
//  About.swift
//  LLDC
//
//  Created by Emojiios on 27/04/2022.
//

import Foundation

class About {

    var coverPhotoPath : String?
    var Details = [AboutDetails]()
    
    init(dictionary:[String:Any]) {
    coverPhotoPath = dictionary["coverPhotoPath"] as? String
        
    for item in dictionary["details"] as? [[String:Any]] ?? [[String:Any]()] {
    Details.append(AboutDetails(dictionary: item))
    }
    }
}

class AboutDetails {
    var title : String?
    var body : String?
    
    init(dictionary:[String:Any]) {
    title = dictionary["title"] as? String
    body = dictionary["body"] as? String
    }
}
