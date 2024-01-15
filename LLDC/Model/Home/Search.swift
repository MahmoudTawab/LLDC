//
//  Search.swift
//  LLDC
//
//  Created by Emojiios on 04/07/2022.
//

import Foundation

struct Search {

    var KeyWordId : String?
    var KeyWord : String?
    
    init(Data:[String:Any]) {
    self.KeyWord = Data["KeyWord"] as? String
    self.KeyWordId = Data["KeyWordId"] as? String
    }
}
