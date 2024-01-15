//
//  MapVC.swift
//  LLDC
//
//  Created by Emojiios on 18/05/2022.
//

import UIKit
import MapKit
import SDWebImage
import GoogleMaps
import CoreLocation

class MapVC: ViewController ,GMSMapViewDelegate {
    
    var markers = [GMSMarker]()
    static var Areas = [MapPlaces]()
    let customMarkerWidth = ControlWidth(50)
    let customMarkerHeight = ControlWidth(56)


    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        view.addSubview(Dismiss)
        Dismiss.IconImage.tintColor = .black
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(40), width: view.frame.width - ControlX(30), height: ControlWidth(40))
        
    
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.delegate = self
        
        view.addSubview(ViewBottom)
        ViewBottom.frame = CGRect(x: ControlX(15), y: self.view.frame.maxY, width: self.view.frame.width - ControlX(30), height: ControlWidth(160))
        
        view.addSubview(LocationButton)
        LocationButton.frame = CGRect(x: view.frame.maxX - ControlX(70), y: ViewBottom.frame.minY - ControlWidth(100), width: ControlWidth(50), height: ControlWidth(50))
      
        ViewBottom.addSubview(ImageView)
        ImageView.topAnchor.constraint(equalTo: ViewBottom.topAnchor, constant: ControlX(20)).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: ViewBottom.leadingAnchor, constant: ControlX(15)).isActive = true
        ImageView.heightAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        ImageView.widthAnchor.constraint(equalTo: ImageView.heightAnchor).isActive = true
                    
        ViewBottom.addSubview(GoGps)
        GoGps.heightAnchor.constraint(equalToConstant: ControlWidth(46)).isActive = true
        GoGps.widthAnchor.constraint(equalTo: GoGps.heightAnchor).isActive = true
        GoGps.centerYAnchor.constraint(equalTo: ViewBottom.centerYAnchor).isActive = true
        GoGps.trailingAnchor.constraint(equalTo: ViewBottom.trailingAnchor, constant: ControlX(-10)).isActive = true
        GoGps.imageView?.transform = "lang".localizable == "ar" ? CGAffineTransform(rotationAngle: .pi) : .identity

        
        ViewBottom.addSubview(StackLabel)
        StackLabel.heightAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        StackLabel.topAnchor.constraint(equalTo: ViewBottom.topAnchor, constant: ControlX(30)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor, constant: ControlX(10)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: GoGps.leadingAnchor ,constant: ControlWidth(-10)).isActive = true
    
        GetDataMapPlaces()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let newLocation = CLLocationCoordinate2D(latitude: 30.009563475365336, longitude: 31.251994707854237)
        mapView.padding = UIEdgeInsets(top: 0, left: ControlX(10), bottom: ControlWidth(20), right: ControlX(10))
        self.mapView.camera = GMSCameraPosition.camera(withTarget: newLocation, zoom: 16)
        self.mapView.setMinZoom(16, maxZoom: .infinity)
//        GetMyLocation()
    }
    
    var mapView: GMSMapView = {
        let v = GMSMapView()
        v.mapType = .satellite
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func addMarkers() {
        markers.removeAll()
        for (index, place) in MapVC.Areas.enumerated() {
            let marker = GMSMarker()
//            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), imageName: place.Info?.mapIcon, borderColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1), tag: index)
//            marker.iconView = customMarker
            
            SDWebImageManager.shared.loadImage(
            with: URL(string: place.Info?.mapIcon ?? ""),
            options: .highPriority,
            progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                marker.icon = image
            }
            
            marker.position = CLLocationCoordinate2D(latitude: place.Info?.lat ?? 0, longitude: place.Info?.long ?? 0)
            marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0)
            marker.map = self.mapView
            marker.zIndex = Int32(index)
            marker.userData = place
            markers.append(marker)
        }
    }
    
    func focusMapToShowAllMarkers() {
        if let firstLocation = markers.first?.position {
        var bounds =  GMSCoordinateBounds(coordinate: firstLocation, coordinate: firstLocation)
        for marker in markers {
        bounds = bounds.includingCoordinate(marker.position)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 20)
        self.mapView.animate(with: update)
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        if let place = marker.userData as? MapPlaces {
            marker.tracksInfoWindowChanges = true
            let infoWindow = CustomMarkerInfoWindow()
            infoWindow.tag = 5555
            let height: CGFloat = ControlWidth(65)
            let paddingWith = height + 16 + 32
            infoWindow.imgView.sd_setImage(with: URL(string: place.iconPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            infoWindow.frame = CGRect(x: 0, y: 0, width: getEstimatedWidthForMarker(place, padding: paddingWith) + paddingWith, height: height)
            infoWindow.txtLabel.text = place.title
            infoWindow.subtitleLabel.text = place.areaName
            
            AreasId = place.id
            screenId = place.screenId
            LocationSelect = CLLocationCoordinate2D(latitude: place.Info?.lat ?? 0, longitude: place.Info?.long ?? 0)
            TitleLabel.TextLabel = place.title ?? ""
            LocationLabel.TextLabel = place.Info?.address ?? ""
            TimeLabel.TextLabel = "\(place.openingHoursFrom ?? "") - \(place.openingHoursTo ?? "")"
            ImageView.sd_setImage(with: URL(string: place.iconPath ?? ""), placeholderImage: UIImage(named: "Group 26056"))
            ShowViewBottom(Show:true)
            return infoWindow
        }
        return nil
    }
    
    var LocationSelect:CLLocationCoordinate2D?
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        ShowViewBottom(Show:false)
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let place = marker.userData as? MapPlaces {
            print("Info window tapped", place)
        }
    }
    
    func getEstimatedWidthForMarker(_ place: MapPlaces, padding: CGFloat) -> CGFloat {
        var estimatedWidth: CGFloat = 0
        let infoWindow = CustomMarkerInfoWindow()
        let maxWidth = (UIDevice.current.userInterfaceIdiom == .pad ? UIScreen.main.bounds.width * 0.7 : UIScreen.main.bounds.width * 0.8) - padding
        let titleWidth = (place.title ?? "").textSizeWithFont(infoWindow.txtLabel.font)
        let subtitleWidth = (place.areaName ?? "").textSizeWithFont(infoWindow.subtitleLabel.font)
        estimatedWidth = min(maxWidth, max(titleWidth.width , subtitleWidth.width))
        
        return estimatedWidth
    }
    
    lazy var LocationButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = .white
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.layer.cornerRadius = ControlX(25)
        Button.setImage(UIImage(named: "Location"), for: .normal)
        Button.addTarget(self, action: #selector(ActionLocation), for: .touchUpInside)
        return Button
    }()


    @objc func ActionLocation() {
    let newLocation = CLLocationCoordinate2D(latitude: 30.00903004132133, longitude: 31.25072595111179)
    self.mapView.animate(toZoom: 16)
    self.mapView.animate(toLocation: newLocation)
    self.mapView.setMinZoom(16, maxZoom: .infinity)
    }
    
    
//    Set View bottom
    func ShowViewBottom(Show:Bool) {
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: []) {
    if Show {
    self.ViewBottom.alpha = 1
    self.mapView.padding = UIEdgeInsets(top: 0, left: ControlX(10), bottom: ControlWidth(120), right: ControlX(10))
    self.ViewBottom.frame = CGRect(x: ControlX(15), y: self.view.frame.maxY - ControlWidth(150), width: self.view.frame.width - ControlX(30), height: ControlWidth(160))
    self.LocationButton.frame = CGRect(x: self.view.frame.maxX - ControlX(70), y: self.ViewBottom.frame.minY - ControlWidth(70), width: ControlWidth(50), height: ControlWidth(50))
    }else{
    self.ViewBottom.alpha = 0
    self.mapView.padding = UIEdgeInsets(top: 0, left: ControlX(10), bottom: ControlWidth(20), right: ControlX(10))
    self.ViewBottom.frame = CGRect(x: ControlX(15), y: self.view.frame.maxY, width: self.view.frame.width - ControlX(30), height: ControlWidth(160))
    self.LocationButton.frame = CGRect(x: self.view.frame.maxX - ControlX(70), y: self.ViewBottom.frame.minY - ControlWidth(100), width: ControlWidth(50), height: ControlWidth(50))
    }
    }
    }
    
    lazy var ViewBottom:UIView = {
        let View = UIView()
        View.alpha = 0
        View.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        View.layer.cornerRadius = ControlX(15)
        return View
    }()
    
    lazy var ImageView : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.layer.cornerRadius = ControlX(8)
        ImageView.isUserInteractionEnabled = true
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ShowAreasDetails)))
        return ImageView
    }()
    
    lazy var TitleLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.backgroundColor = #colorLiteral(red: 0.07388865203, green: 0.4815660715, blue: 0.5901879668, alpha: 1)
        View.IconImage.setImage(UIImage(named: ""), for: .normal)
        View.IconImage.layer.cornerRadius = ControlHeight(6)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(12))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(12))
        return View
    }()
    
    lazy var LocationLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "Location"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(13))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(10.5))
        return View
    }()
    
    lazy var TimeLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "clock"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(12))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(10.5))
        return View
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TitleLabel,LocationLabel,TimeLabel])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(3)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.isUserInteractionEnabled = true
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ShowAreasDetails)))
        return Stack
    }()
    
    var screenId : Int?
    var AreasId : String?
    @objc func ShowAreasDetails() {
    if let Id = AreasId {
        switch screenId {
        case 1:
        let Restaurant = RestaurantVC()
        Restaurant.AreaId = Id
        Present(ViewController: self, ToViewController: Restaurant)
        case 2:
        let Retail = RetailVC()
        Retail.AreaId = Id
        Present(ViewController: self, ToViewController: Retail)
        case 3:
        let Events = EventsVC()
        Events.AreaId = Id
        Present(ViewController: self, ToViewController: Events)
        case 4:
        let Library = LibraryVC()
        Library.AreaId = Id
        Present(ViewController: self, ToViewController: Library)
        case 5:
        let Museum = MuseumVC()
        Museum.AreaId = Id
        Present(ViewController: self, ToViewController: Museum)
        case 6:
        let Corporate = CorporateVC()
        Corporate.AreaId = Id
        Present(ViewController: self, ToViewController: Corporate)
        default:
        break
        }
    }
    }
    
    lazy var GoGps : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = .white
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.layer.cornerRadius = ControlX(23)
        Button.transform = CGAffineTransform(rotationAngle: .pi)
        Button.setImage(UIImage(named: "right-arrow"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionGoGps), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionGoGps() {
    let latitude = LocationSelect?.latitude ?? 0
    let longitude = LocationSelect?.longitude ?? 0

    let regionDistance:CLLocationDistance = 100
    let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
    let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
    let options = [
    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
    MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
    ]
    let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = "Your Location"
    mapItem.openInMaps(launchOptions: options)
    }
    
    func GetDataMapPlaces()  {
//    if MapVC.Areas.count == 0 {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//        let token = defaults.string(forKey: "jwt") ?? ""
//        let api = "\(url + GetAllMapPlaces)"
//
//        let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                       "Platform": "I",
//                                       "Lang": "en"]

        self.ViewDots.beginRefreshing()
//        PostAPI(api: api, token: token, parameters: parameters) { _ in
//        } DictionaryData: { ـ in
//        } ArrayOfDictionary: { data in
        

        let data = [
            ["id" : "","iconPath" : "https://images.memphistours.com/large/844737225_3%20(2)%20(1).jpg","title" : "Egyptian Museum","areaName" : "Museum","openingHoursFrom" : "12:30 am","openingHoursTo" : "02:30 am","locationInfo" : ["lat" : 30.008268048942845 ,"long" : 31.2524961092041 ,"address" : "Egyptian Museum","mapIcon" : ""],"screenId" :1, "screenName" : ""],
        
            ["id" : "","iconPath" : "https://retaildesignblog.net/wp-content/uploads/2013/12/Plethora-fragrances-store-by-RETAIL-access-Dubai-United-Arab-Emirates.jpg","title" : "Plethora ","areaName" : "Plethora","openingHoursFrom" : "12:30 am","openingHoursTo" : "02:30 am","locationInfo" : ["lat" : 30.009020590374163 ,"long" :  31.25161634466133,"address" : "Plethora Egypt","mapIcon" : ""],"screenId" :1, "screenName" : ""],
        
            ["id" : "","iconPath" : "https://images.memphistours.com/large/844737225_3%20(2)%20(1).jpg","title" : "Egyptian Museum","areaName" : "Museum","openingHoursFrom" : "12:30 am","openingHoursTo" : "02:30 am","locationInfo" : ["lat" : 30.00975454503663 ,"long" : 31.251433954451237,"address" : "Egyptian Museum","mapIcon" : ""],"screenId" :1, "screenName" : ""],
            
            ["id" : "","iconPath" : "https://images.memphistours.com/large/844737225_3%20(2)%20(1).jpg","title" : "Egyptian Museum", "areaName" : "Museum","openingHoursFrom" : "12:30 am","openingHoursTo" : "02:30 am","locationInfo" : ["lat" : 30.01058139884771 ,"long" : 31.253268585387993,"address" : "Egyptian Museum","mapIcon" : ""],"screenId" :1, "screenName" : ""]
        ]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            
            for item in data {MapVC.Areas.append(MapPlaces(dictionary: item))}
            self.addMarkers()
            self.focusMapToShowAllMarkers()
            self.ViewDots.endRefreshing {}
            
        }
        
        
//        } Err: { error in
//        self.ViewDots.endRefreshing(error, .error) {}
//        }
//        }else {
//        self.addMarkers()
//        self.focusMapToShowAllMarkers()
//        }
    }
    
    
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
//        let imgName = customMarkerView.imageName
//        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), imageName: imgName, borderColor: UIColor(red:0.89, green:0.15, blue:0.21, alpha:1.0), tag: customMarkerView.tag)
//        marker.iconView = customMarker
//        return false
//    }
    
//    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
//        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
//        let imgName = customMarkerView.imageName
//        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), imageName: imgName, borderColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1), tag: customMarkerView.tag)
//        marker.iconView = customMarker
//    }
    
//    var locationManager = CLLocationManager()
//    func GetMyLocation() {
//          locationManager.requestAlwaysAuthorization()
//             if CLLocationManager.locationServicesEnabled(){
//                locationManager.delegate = self
//                locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
//                locationManager.distanceFilter = 500
//                locationManager.requestWhenInUseAuthorization()
//                locationManager.requestAlwaysAuthorization()
//                locationManager.startUpdatingLocation()
//          }
//            mapView.settings.myLocationButton = true
//            mapView.settings.zoomGestures = true
//            mapView.animate(toViewingAngle: 45)
//    }
    
}

//extension MapVC: CLLocationManagerDelegate {

//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let newLocation = locations.last
//        mapView.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 14.0) // show your device location on map
//        mapView.settings.myLocationButton = true
//        let lat = (newLocation?.coordinate.latitude)!
//        let long = (newLocation?.coordinate.longitude)!
//
//        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
//        let marker = GMSMarker()
//        marker.position = center
//        marker.title = "Location"
//        marker.snippet = "My Location"
//        marker.map = mapView
//    }

//}
