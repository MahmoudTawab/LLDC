//
//  SendMessageVC.swift
//  Volt (iOS)
//
//  Created by Emojiios on 08/02/2022.
//

import UIKit

class SendMessageVC: ViewController  {

    override func viewDidLoad() {
    super.viewDidLoad()
    SetUpTableView()
    view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
        
    fileprivate func SetUpTableView() {
        
    view.addSubview(Dismiss)
    Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
    Dismiss.TextLabel = "Send Message".localizable
    Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15), width: view.frame.width, height: view.frame.height - ControlHeight(80))

    ViewScroll.addSubview(HelpYouLabel)
    HelpYouLabel.frame = CGRect(x: ControlX(15), y: 0 , width: view.frame.width - ControlWidth(30), height: ControlWidth(30))
        
    ViewScroll.addSubview(HowCanWeHelpYou)
    let height = HelpYou.TextHeight(view.frame.width - ControlWidth(30), font: UIFont.systemFont(ofSize: ControlWidth(16)), Spacing: ControlWidth(4)) ?? ControlWidth(80)
    HowCanWeHelpYou.frame = CGRect(x: ControlX(15), y: HelpYouLabel.frame.maxY + ControlY(15) , width: view.frame.width - ControlWidth(30), height: height)
        
    ViewScroll.addSubview(NameTF)
    NameTF.frame = CGRect(x: ControlX(15), y: HowCanWeHelpYou.frame.maxY + ControlY(10) , width: view.frame.width - ControlWidth(30), height: ControlWidth(40))
        
    ViewScroll.addSubview(SubjectTF)
    SubjectTF.frame = CGRect(x: ControlX(15), y: NameTF.frame.maxY + ControlY(20) , width: view.frame.width - ControlWidth(30), height: ControlWidth(40))
            
    ViewScroll.addSubview(TextView)
    TextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
    TextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
    TextView.topAnchor.constraint(equalTo: SubjectTF.bottomAnchor, constant: ControlX(48)).isActive = true
    TextView.heightAnchor.constraint(equalToConstant: ControlWidth(200)).isActive = true
  
    ViewScroll.addSubview(ViewLine)
    ViewLine.bottomAnchor.constraint(equalTo: TextView.bottomAnchor).isActive = true
    ViewLine.leadingAnchor.constraint(equalTo: TextView.leadingAnchor).isActive = true
    ViewLine.trailingAnchor.constraint(equalTo: TextView.trailingAnchor).isActive = true
    ViewLine.heightAnchor.constraint(equalToConstant: ControlX(1)).isActive = true

    ViewScroll.addSubview(SendButton)
    SendButton.leadingAnchor.constraint(equalTo: TextView.leadingAnchor).isActive = true
    SendButton.trailingAnchor.constraint(equalTo: TextView.trailingAnchor).isActive = true
    SendButton.topAnchor.constraint(equalTo: TextView.bottomAnchor, constant: ControlY(40)).isActive = true
    SendButton.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
    ViewScroll.updateContentViewSize(0)
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        return Scroll
    }()

    lazy var HelpYouLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.text = "How can we help you?".localizable
        Label.font = UIFont(name: "SourceSansPro-Black", size: ControlWidth(18))
        return Label
    }()
    
    let HelpYou = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo"
    lazy var HowCanWeHelpYou : UITextView = {
        let TV = UITextView()
        TV.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        TV.text = HelpYou
        TV.tintColor = .clear
        TV.isEditable = false
        TV.isSelectable = false
        TV.isScrollEnabled = false
        TV.autocorrectionType = .no
        TV.backgroundColor = .clear
        TV.spasing = ControlWidth(4)
        TV.font = UIFont(name: "SourceSansPro-Regular", size:  ControlWidth(16))
        TV.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        return TV
    }()

    lazy var NameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.translatesAutoresizingMaskIntoConstraints = true
        tf.attributedPlaceholder = NSAttributedString(string: "Name (Autofilled)".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var SubjectTF : FloatingTF = {
        let tf = FloatingTF()
        tf.translatesAutoresizingMaskIntoConstraints = true
        tf.attributedPlaceholder = NSAttributedString(string: "Subject".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()

    
    lazy var TextView : GrowingTextView = {
    let TV = GrowingTextView()
    TV.placeholder = "Message".localizable
    TV.minHeight = ControlWidth(40)
    TV.maxHeight = ControlWidth(200)
    TV.placeholderColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)
    TV.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    TV.textColor = .black
    TV.clipsToBounds = true
    TV.backgroundColor = .clear
    TV.autocorrectionType = .no
    TV.translatesAutoresizingMaskIntoConstraints = false
    TV.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(15))
    return TV
    }()
    
    
    lazy var ViewLine:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    lazy var SendButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Send Message".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSendMessage), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionSendMessage() {
    if NameTF.NoError() && SubjectTF.NoError() && TextView.NoError() {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    guard let Name = NameTF.text else{return}
    guard let Subject = SubjectTF.text else{return}
    guard let Message = TextView.text else{return}

    let api = "\(url + AddClientMessage)"
    let sqlId = getProfileObject().sqlId ?? ""
    let token = defaults.string(forKey: "jwt") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                   "platform": "I",
                                    "SqlId": sqlId,
                                    "deviceID": udid,
                                     "Name": Name,
                                     "subject":Subject,
                                     "message": Message]

    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.NameTF.text = ""
    self.TextView.text = ""
    self.SubjectTF.text = ""
    self.ViewDots.endRefreshing("Success Send Your Message".localizable, .success) {}
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }
    }
}
