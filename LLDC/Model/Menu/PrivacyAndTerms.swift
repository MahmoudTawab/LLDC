//
//  PrivacyAndTerms.swift
//  LLDC
//
//  Created by Emojiios on 27/04/2022.
//

import Foundation

class PrivacyAndTerms {

    var title : String?
    var body : String?
    
    init(dictionary:[String:Any]) {
    title = dictionary["title"] as? String
    body = dictionary["body"] as? String
    }
    
}

