//
//  FAQ.swift
//  LLDC
//
//  Created by Emojiios on 27/04/2022.
//

import Foundation

class FAQ {
    
    var id:String?
    var title:String?
    var body:String?
    var FAQHidden = false
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    title = dictionary["title"] as? String
    body = dictionary["body"] as? String
    }
}
