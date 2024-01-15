//
//  LaunchScreen.swift
//  LLDC
//
//  Created by Emojiios on 28/03/2022.
//

import UIKit
import FirebaseAuth

class LaunchScreen: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
            
        view.addSubview(ImageView)
        ImageView.frame = view.bounds
       
        ImageView.addSubview(ViewBorder)
        ViewBorder.frame = CGRect(x: ControlX(20), y: ControlX(40), width: view.frame.width - ControlX(40), height: view.frame.height - ControlX(80))
        Animate()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.Device()
        self.DeviceLang()
        }
    }

    lazy var ViewBorder:UIView = {
        let View = UIView()
        View.layer.borderWidth = 1
        View.layer.cornerRadius = ControlX(12)
        View.layer.borderColor = UIColor.white.cgColor
        return View
    }()

    lazy var ImageView : UIImageView = {
        let ImageView = UIImageView()
        ImageView.contentMode = .scaleAspectFill
        ImageView.image = UIImage(named: "Launch")
        return ImageView
    }()


    func Animate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        UIView.animate(withDuration: 0.3, delay: 0, options: []) {
        self.ImageView.alpha = 0.8
        self.ImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
        UIView.animate(withDuration: 0.3, delay: 0, options: []) {
        self.ImageView.alpha = 1
        self.ImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { _ in
        UIView.animate(withDuration: 0.3, delay: 0, options: []) {
        self.ImageView.alpha = 0.8
        self.ImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
        UIView.animate(withDuration: 0.3) {
        self.ImageView.alpha = 1
        self.ImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        }
        }
        }
        }
    }
    
    var main : Main?
    func Device() {
    let url = defaults.string(forKey: "API") ?? "https://lldc.azurewebsites.net/"
    let api = "\(url + AddDevice)"
    
    let modelName = UIDevice.modelName
    let version = UIDevice.current.systemVersion
    let fireToken = defaults.string(forKey: "fireToken") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
    let parameters:[String:Any] = ["Token": "bc2bd4668ce3447aa9d5ee15fd9f6498254c9d2a093343cc921055aafc48fbdc",
                                   "AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                   "Platform": "I",
                                   "FireToken": fireToken,
                                   "DeviceID": udid,
                                   "DeviceModel": modelName,
                                   "Manufacturer": "Iphone",
                                   "OsVersion": version,
                                   "VersionCode": "1"]

    PostAPI(timeout: 20,api: api, token: nil, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.main = Main(dictionary: data)
    self.perform(#selector(self.IfNotUser), with: self, afterDelay: 3)
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.perform(#selector(self.IfNotUser), with: self, afterDelay: 3)
    }
    }
    
    @objc func IfNotUser() {
    if getProfileObject().uid == nil {
    do {
    try Auth.auth().signOut()
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
    if key != "API" && key != "Url" && key != "WhatsApp" && key != "fireToken" && key != "jwt" {
    defaults.removeObject(forKey: key)}}
    FirstController(SignInController())
    }catch let signOutErr {
    print(signOutErr.localizedDescription)
    }
    }else{
    FirstController(TabBarController())
    }
    }
    

    func DeviceLang() {
    let url = defaults.string(forKey: "API") ?? "https://lldc.azurewebsites.net/"

    let api = "\(url + AddDeviceLang)"
    let sqlId = getProfileObject().sqlId ?? ""
    let token = defaults.string(forKey: "jwt") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""

    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                   "platform": "I",
                                   "lang": "lang".localizable,
                                   "sqlId": sqlId,
                                   "deviceId": udid]

    PostAPI(timeout: 20,api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { _ in
    }
    }
    
}

