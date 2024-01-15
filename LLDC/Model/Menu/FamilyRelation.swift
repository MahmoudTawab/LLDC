//
//  FamilyRelation.swift
//  LLDC
//
//  Created by Emojiios on 26/04/2022.
//

import Foundation

class FamilyRelation {

    var Id: Int?
    var name: String?

    init(dictionary:[String:Any]) {
    Id = dictionary["id"] as? Int
    name = dictionary["name"] as? String
    }
}
