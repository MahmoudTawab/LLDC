//
//  API.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 05/12/2021.
//


import FirebaseFirestore

    let defaults = UserDefaults.standard

    func LodBaseUrl() {
    Firestore.firestore().collection("API").document("IOS").addSnapshotListener { (querySnapshot, err) in
    if let err = err {
    print(err.localizedDescription)
    return
    }

    guard let data = querySnapshot?.data() else {return}
    DispatchQueue.main.async {
    let DebugBase = data["DebugBaseUrl"] as? String
    let ReleaseBase = data["ReleaseBaseUrl"] as? String
    let WhatsApp = data["WhatsAppNumber"] as? String

    defaults.set(DebugBase, forKey: "API")
    defaults.set(ReleaseBase, forKey: "Url")
    defaults.set(WhatsApp, forKey: "WhatsApp")
    }
    }
    }


    ///
///
    var GUID = "00000000-0000-0000-0000-000000000000"
///

    let login = "login"

    let SignUpScreenInfo = "GetSignUpScreenInfo"

    let SendSms = "SendSms"

    let AddMembership = "AddMembership"

    let GetProfile = "GetProfile"

    let AddRecommendFriend = "AddRecommendFriend"

    let CheckMember = "CheckMember"

    let AddFamilyMember = "AddFamilyMember"

    let GetFamilyRelation = "GetFamilyRelation"

    let GetCities = "GetCities"

    let UpdateProfile = "UpdateProfile"

    let GetPrivacyPolicy = "GetPrivacyPolicy"

    let GetTermsAndConditions = "GetTermsAndConditions"

    let GetAboutUs = "GetAboutUs"

    let GetFAQ = "GetFAQ"

    let AddDevice = "AddDevice"

    let GetMainScreen = "GetMainScreen"

    let GetListAreas = "GetListAreas"

    let AddClientMessage = "AddClientMessage"

    let GetNotification = "GetNotification"

    let ReadNotification = "ReadNotification"

    let DeleteNotification = "DeleteNotification"

    let GetAllMapPlaces = "GetAllMapPlaces"

    let DeleteFamilyMember = "DeleteFamilyMember"

    let UpdateFamilyMember = "UpdateFamilyMember"

    let GetAreaDetails = "GetAreaDetails"

    let GetPlacesCategories = "GetPlacesCategories"

    let GetPlacesUtilities = "GetPlacesUtilities"

    let GetPlaceDetails = "GetPlaceDetails"

    let AddFavoritePlaces = "AddFavoritePlaces"

    let RemoveFavoritePlaces = "RemoveFavoritePlaces"

    let GetFavoritePlaces = "GetFavoritePlaces"

    let GetPlaceReviews = "GetPlaceReviews"

    let GetPendingReviews = "GetPendingReviews"

    let AddReviews = "AddReviews"

    let AddCorporateEvents = "AddCorporateEvents"

    let RestaurantBookReservationByClient = "RestaurantBookReservationByClient"

    let GetCategories = "GetCategories"

    let GetReservations = "GetReservations"

    let GetReservationsDetails = "GetReservationsDetails"

    let CanceAllReservation = "CanceAllReservation";

    let CanceReservation = "CanceReservation";

    let AddDeviceLang = "AddDeviceLang";

    let GetMyQRCode = "GetMyQRCode"

    let BookReservationByClient = "BookReservationByClient"

    let GetRecentSearches = "GetRecentSearches"

    let GetSearchResult = "GetSearchResult"
