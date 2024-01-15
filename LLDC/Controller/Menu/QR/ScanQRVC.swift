//
//  ScanQRVC.swift
//  LLDC
//
//  Created by Emojiios on 31/03/2022.
//

import UIKit
import WebKit
import SDWebImage

class ScanQRVC: ViewController, WKUIDelegate, WKNavigationDelegate {

    var QrCode:QRCode?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        NormalQRCode()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Dismiss.TextLabel = "Scan QR".localizable
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
        view.addSubview(ViewQR)
        ViewQR.frame = CGRect(x: ControlX(22), y: Dismiss.frame.maxY + ControlY(30), width: view.frame.width - ControlX(44), height: view.frame.width - ControlX(44))
        
        ViewQR.addSubview(ImageQR)
        ImageQR.frame = CGRect(x: ControlX(10), y: ControlX(10), width: ViewQR.frame.width - ControlX(20), height: ViewQR.frame.height - ControlX(20))
        
        view.addSubview(ViewPlatinum)
        ViewPlatinum.frame = CGRect(x: ControlX(20), y: view.frame.maxY - ControlWidth(180), width: view.frame.width - ControlX(40), height: ControlWidth(140))
        
        ViewPlatinum.addSubview(StackView)
        StackView.trailingAnchor.constraint(equalTo: ViewPlatinum.trailingAnchor, constant: ControlX(-10)).isActive = true
        StackView.leadingAnchor.constraint(equalTo: ViewPlatinum.leadingAnchor, constant: ControlX(10)).isActive = true
        StackView.topAnchor.constraint(equalTo: ViewPlatinum.topAnchor, constant: ControlX(25)).isActive = true
        StackView.bottomAnchor.constraint(equalTo: ViewPlatinum.bottomAnchor, constant: ControlX(-25)).isActive = true
        StackView.arrangedSubviews[0].widthAnchor.constraint(equalTo: StackView.widthAnchor, multiplier: 1/1.7).isActive = true
    }

    lazy var ViewQR : UIImageView = {
        let ImageView = UIImageView()
        ImageView.isHidden = true
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleToFill
        ImageView.image = UIImage(named: "ViewQR")
        return ImageView
    }()
    
    lazy var ImageQR : WKWebView = {
        let ImageView = WKWebView()
        ImageView.isHidden = true
        ImageView.uiDelegate = self
        ImageView.clipsToBounds = true
        ImageView.navigationDelegate = self
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.scrollView.isScrollEnabled = false
        return ImageView
    }()
    
    lazy var ViewPlatinum:UIView = {
        let View = UIView()
        View.isHidden = true
        View.layer.shadowRadius = 4
        View.layer.shadowOpacity = 0.4
        View.backgroundColor = .white
        View.layer.shadowOffset = .zero
        View.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        View.layer.cornerRadius = ControlX(10)
        return View
    }()
    
    lazy var StackView : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [StackPlatinum,PlatinumImage])
        Stack.axis = .horizontal
        Stack.distribution = .equalSpacing
        Stack.spacing = ControlWidth(5)
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    

    lazy var PlatinumTitle : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.backgroundColor = .clear
        Button.setImage(UIImage(named: "Menu1"), for: .normal)
        Button.setTitle(" \("Become Platinum Member".localizable)", for: .normal)
        Button.contentHorizontalAlignment =  "lang".localizable == "ar" ? .right : .left
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(12.5))
        Button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        return Button
    }()

    lazy var PlatinumDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.text = "Get the Vip Membership andenjoy the benefits".localizable
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(13))
        return Label
    }()
    
    lazy var KnowMore : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.backgroundColor = .clear
        Button.setTitle("Know More".localizable, for: .normal)
        Button.semanticContentAttribute = .forceRightToLeft
        Button.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        Button.addTarget(self, action: #selector(ActionKnowMore), for: .touchUpInside)
        Button.contentHorizontalAlignment =  "lang".localizable == "ar" ? .right : .left
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1), for: .normal)
        Button.setImage(UIImage(named: "right-arrow")?.withInset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)), for: .normal)
        return Button
    }()

    @objc func ActionKnowMore() {
    Present(ViewController: self, ToViewController: BecomeMemberVC())
    }
    
    
    lazy var StackPlatinum : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [PlatinumTitle,PlatinumDetails,KnowMore])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var PlatinumImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.image = UIImage(named: "ScreenShot")
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionKnowMore)))
        return ImageView
    }()
    
    func NormalQRCode() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//        
//    let api = "\(url + GetMyQRCode)"
//    let sqlId = getProfileObject().sqlId ?? ""
//    let token = defaults.string(forKey: "jwt") ?? ""
//
//    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                   "platform": "I",
//                                   "lang": "lang".localizable,
//                                   "sqlId": sqlId]

    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        let data = ["qrCodePath" : "https://www.dontwasteyourtime.co.uk/wp-content/uploads/2011/11/Unitag-QR-Code-Resource-Page2-BITLY.png","memberTypeId" : 1,"memberType" : "m","iconPath" : "https://icon-library.com/images/pinterest-icon-download-free/pinterest-icon-download-free-20.jpg","isPlatinium" : false] as [String : Any]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.QrCode = QRCode(dictionary: data)
            self.IfNoData()
        }
        
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.IfNoData()
//    self.SetUpIsError(error, true) {self.NormalQRCode()}
//    }
    }
    
    func IfNoData() {
    if let URL = URL(string: QrCode?.qrCodePath ?? "") {
    let request = URLRequest(url: URL)
    self.ImageQR.load(request)
    }else{
    LoadQR()
    }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    LoadQR()
    }

    func LoadQR() {
        self.ViewQR.isHidden = QrCode != nil ? false : true
        self.ImageQR.isHidden = QrCode != nil ? false : true
        self.ViewNoData.isHidden = QrCode != nil ? true : false
        self.ViewPlatinum.isHidden = self.QrCode?.isPlatinium == false ? false:true
        self.ViewDots.endRefreshing {}
    }
}


