//
//  Profile.swift
//  LLDC
//
//  Created by Emojiios on 25/04/2022.
//

import Foundation

class Profile {

    var uid: String?
    var sqlId: String?
    var fullName: String?
    var email: String?
    var phone: String?
    var emailVerified: Bool?
    var phoneVerified: Bool?
    var male: Bool?
    var birthday: String?
    var cityId: Int?
    var city: String?
    var homeAddress: String?
    var linkedIn: String?
    var facebook: String?
    var instagram: String?
    var familyMembers: String?
    var qrPath: String?
    var receiveNotifications: Bool?
    var receiveEmail: Bool?
    var company: String?
    var workLocation: String?
    var memberTypeId: Int?
    var memberType: String?
    var profileImg: String?
    var iconPath: String?
    var isplatinium: Bool?
    
    var Family = [FamilyMembers]()
    var Select = true
    
    init(dictionary:[String:Any]) {
        
        uid = dictionary["uid"] as? String
        sqlId = dictionary["sqlId"] as? String
        fullName = dictionary["fullName"] as? String
        email = dictionary["email"] as? String
        phone = dictionary["phone"] as? String
        emailVerified = dictionary["emailVerified"] as? Bool
        phoneVerified = dictionary["phoneVerified"] as? Bool
        male = dictionary["male"] as? Bool
        birthday = dictionary["birthday"] as? String
        homeAddress = dictionary["homeAddress"] as? String
        linkedIn = dictionary["linkedIn"] as? String
        facebook = dictionary["facebook"] as? String
        instagram = dictionary["instagram"] as? String
        familyMembers = dictionary["familyMembers"] as? String
        qrPath = dictionary["qrPath"] as? String
        receiveNotifications = dictionary["receiveNotifications"] as? Bool
        receiveEmail = dictionary["receiveEmail"] as? Bool
        company = dictionary["company"] as? String
        workLocation = dictionary["workLocation"] as? String
        memberType = dictionary["memberType"] as? String
        memberTypeId = dictionary["memberTypeId"] as? Int
        profileImg = dictionary["profileImg"] as? String
        cityId = dictionary["cityId"] as? Int
        city = dictionary["city"] as? String
        
        iconPath = dictionary["iconPath"] as? String
        isplatinium = dictionary["isplatinium"] as? Bool
        if let family = dictionary["familyMembers"] as? [[String:Any]] {
        for item in family {
        Family.append(FamilyMembers(dictionary: item))
        }
        }
    }
}

func getProfileObject() -> Profile {
let User = Profile(dictionary: [String:Any]())
if let data = defaults.object(forKey: "profile") as? Data {
if let decodedPeople = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String:Any] {
let user = Profile(dictionary: decodedPeople)
return user
}
}
return User
}

///  Set Up family

class FamilyMembers {
    
    var id: String?
    var email: String?
    var fullName: String?
    var profileImg: String?
    var phone: String?
    var birthday: String?
    var activated : Bool?
    var relationId: Int?
    var relation: String?
    var createdIn: String?
    var Select = true
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    email = dictionary["email"] as? String
    fullName = dictionary["fullName"] as? String
    profileImg = dictionary["profileImg"] as? String
    phone = dictionary["phone"] as? String
    birthday = dictionary["birthday"] as? String
    activated = dictionary["activated"] as? Bool
    relationId = dictionary["relationId"] as? Int
    relation = dictionary["relation"] as? String
    createdIn = dictionary["createdIn"] as? String
    }
}

struct FamilyMember : Codable {
    var memberId : String?
}
