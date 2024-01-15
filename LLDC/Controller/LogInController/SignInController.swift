//
//  SignInController.swift
//  LLDC
//
//  Created by Emojiios on 28/03/2022.
//

import UIKit
import FirebaseAuth

class SignInController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        SetUpItems()
    }
        
    fileprivate func SetUpItems() {
        ViewScroll.frame = CGRect(x: 0, y: -TopHeight, width: view.frame.width, height: view.frame.height + TopHeight)
        view.addSubview(ViewScroll)

        ViewScroll.addSubview(ImageLogo)
        ImageLogo.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ControlHeight(210))

        ViewScroll.addSubview(StackItems)
        StackItems.frame = CGRect(x: ControlX(30), y: ImageLogo.frame.maxY + ControlY(20), width: view.frame.width - ControlX(60), height: ControlHeight(360))

        ViewScroll.addSubview(ExploreGuest)
        ExploreGuest.frame = CGRect(x: view.frame.maxX - ControlX(130), y: StackItems.frame.maxY + ControlY(20), width: ControlX(100), height: ControlHeight(40))
        
        ViewScroll.updateContentViewSize(-TopHeight)
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.bounces = false
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()

    lazy var ImageLogo : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleToFill
        ImageView.image = UIImage(named: "Group 57532")
        return ImageView
    }()
    
    lazy var SignInLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(5)
        
        let attributedString = NSMutableAttributedString(string: "Bonjour!".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Black", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.3291127384, green: 0.3332326412, blue: 0.3417333364, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "Sign In to your account".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Black", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(55)).isActive = true
        return Label
    }()
    
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsEmail
        tf.keyboardType = .emailAddress
//        if #available(iOS 11.0, *) {tf.textContentType = .emailAddress} else {}
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Email".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
  
    lazy var PasswordTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsPassword
        tf.isSecureTextEntry = true
        tf.clearButtonMode = .never
        tf.IconImage = UIImage(named: "visibility-1")
        tf.SetUpIcon(LeftOrRight: false, Width: 22, Height: 22)
//        if #available(iOS 11.0, *) {tf.textContentType = .password} else {}
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionPassword), for: .touchUpInside)
        tf.attributedPlaceholder = NSAttributedString(string: "Password".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionPassword() {
        if PasswordTF.IconImage == UIImage(named: "visibility-1") {
            PasswordTF.isSecureTextEntry = false
            PasswordTF.IconImage = UIImage(named: "visibility")
        }else{
            PasswordTF.isSecureTextEntry = true
            PasswordTF.IconImage = UIImage(named: "visibility-1")
        }
    }
    
    lazy var ForgotPassword : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionForgotPasswor)))
        
        let underlinedMessage = NSMutableAttributedString(string: "Forgot password?".localizable, attributes: [.foregroundColor: #colorLiteral(red: 0.7036916041, green: 0.7036916041, blue: 0.7036916041, alpha: 1) ,
                                                        .font:UIFont(name: "SourceSansPro-Regular", size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
                                                        .underlineStyle:NSUnderlineStyle.single.rawValue])
        
        Label.attributedText = underlinedMessage
        return Label
    }()
    
    @objc func ActionForgotPasswor() {
    Present(ViewController: self, ToViewController: ResetPassword())
    }
    
    lazy var StackForgot : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [UIView(),ForgotPassword])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(20)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var SignIn : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Sign In".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSignIn), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()
    
//    var MainData : Account?
    @objc func ActionSignIn() {
    if EmailTF.NoError() && PasswordTF.NoError() && PasswordTF.NoErrorPassword() && EmailTF.NoErrorEmail() {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
        
    let token = defaults.string(forKey: "jwt") ?? ""
    let loginApi = "\(url + login)"
                
    guard let email = EmailTF.text else {return}
    guard let password = PasswordTF.text else {return}
        
    ViewDots.beginRefreshing()
    Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
    if let err = err {
    self.ViewDots.endRefreshing(err.localizedDescription, .error) {}
    return
    }
        

    guard let UID = user?.user.uid else{return}
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                   "platform": "I",
                                   "uid": UID,
                                   "email": email,
                                   "deviceID": udid,
                                   "Lang": "lang".localizable]

    PostAPI(api: loginApi, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    HomeVC.MainData = Main(dictionary: data)
    self.ViewDots.endRefreshing() {
//    if self.account?.IsUser == true {
    FirstController(TabBarController())
//    }else{
//    ShowMessageAlert("Error", "Error".localizable, "Email is already in use", false, {
//    let SignUp = SignUpController()
//    SignUp.EmailTF.text = self.EmailTF.text
//    Present(ViewController: self, ToViewController: SignUp)
//    }, "Sign Up")
//    }
    }
    } ArrayOfDictionary: { _ in
    } Err: { (error) in
    self.ViewDots.endRefreshing() {}
    if error != "" {ShowMessageAlert("Error", "Error".localizable, error, false, self.ActionSignIn)}
    }
    }
    }
    }
    
    lazy var SignUpLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(5)
        style.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: "Don’t have an account?".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Light", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "Apply for membership".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Bold", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1) ,
            .paragraphStyle:style,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]))
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "now!".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Light", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.attributedText = attributedString

        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionSignUp)))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        return Label
    }()
    
    @objc func ActionSignUp() {
    Present(ViewController: self, ToViewController: SignUpController())
    }
    
    lazy var ExploreGuest : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.tintColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.isHidden = true
        Button.backgroundColor = .clear
        Button.contentHorizontalAlignment = .center
        Button.setTitle("Explore".localizable, for: .normal)
        Button.semanticContentAttribute = .forceRightToLeft
        Button.setImage(UIImage(named: "right-arrow"), for: .normal)
        Button.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        Button.addTarget(self, action: #selector(ActionExploreGuest), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1), for: .normal)
        return Button
    }()

    @objc func ActionExploreGuest() {
        FirstController(TabBarController())
    }
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [SignInLabel,EmailTF,PasswordTF,StackForgot,SignIn,SignUpLabel])
        Stack.axis = .vertical
        Stack.backgroundColor = .clear
        Stack.spacing = ControlHeight(5)
        Stack.distribution = .equalSpacing
        return Stack
    }()

}
