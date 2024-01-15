//
//  OTPUpdateProfile.swift
//  LLDC
//
//  Created by Emojiios on 06/04/2022.
//

import UIKit

class OTPUpdateProfile: ViewController {
    
    var Edit:EditPersonalVC?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        SetUpItems()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    UIView.animate(withDuration: 0.5, animations: {
      self.ViewContent.frame = CGRect(x: ControlX(15), y: self.view.frame.maxY, width: self.view.frame.width - ControlX(30), height: self.ViewContent.frame.height)
    }) { (End) in
    self.ViewContent.transform = .identity
    }
    }
    
    fileprivate func SetUpItems() {
        let TopHeight = UIApplication.shared.statusBarFrame.height
        ViewScroll.frame = CGRect(x: 0, y: -TopHeight, width: view.frame.width, height: view.frame.height + TopHeight)
        view.addSubview(ViewScroll)
        
        ViewScroll.addSubview(ViewContent)
        self.ViewContent.frame = CGRect(x: ControlX(15), y: self.view.frame.maxY, width: self.view.frame.width - ControlX(30), height: self.ViewContent.frame.height)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.65, options: []) {
        self.ViewContent.frame = CGRect(x: ControlX(15), y: self.view.center.y - ControlWidth(200), width: self.view.frame.width - ControlX(30), height: ControlWidth(400))
        }
        }
        
        ViewContent.addSubview(StackItems)
        StackItems.topAnchor.constraint(equalTo: ViewContent.topAnchor, constant: ControlX(30)).isActive = true
        StackItems.leadingAnchor.constraint(equalTo: ViewContent.leadingAnchor, constant: ControlX(15)).isActive = true
        StackItems.trailingAnchor.constraint(equalTo: ViewContent.trailingAnchor, constant: ControlX(-15)).isActive = true
        StackItems.bottomAnchor.constraint(equalTo: ViewContent.bottomAnchor, constant: ControlX(-20)).isActive = true
        
        ViewContent.addSubview(CloseButton)
        CloseButton.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        CloseButton.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        CloseButton.topAnchor.constraint(equalTo: ViewContent.topAnchor, constant: ControlX(10)).isActive = true
        CloseButton.trailingAnchor.constraint(equalTo: ViewContent.trailingAnchor, constant: ControlX(-10)).isActive = true

        Number1TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number2TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number3TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number4TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
               
        LabelTimerAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Number1TF.becomeFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.ViewScroll.setContentOffset(CGPoint(x: 0, y: ControlWidth(120)), animated: true)
        }
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
        Scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height - ControlX(160))
        return Scroll
    }()
    
    lazy var VerificationLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(10)
        
        let attributedString = NSMutableAttributedString(string: "OTP Verification".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Black", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "Please enter your OTP, you have received via email , in order to reset your password".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Regular", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        if let PhoneNumber = Edit?.PhoneNumberTF.text {
        let Number = "lang".localizable == "ar" ? PhoneNumber.NumAR():PhoneNumber
        let Phone = String(Number.enumerated().map { $0 > 0 && $0 % 3 == 0 ? [" ",$1] : [$1]}.joined())
        attributedString.append(NSAttributedString(string: "\(Phone)  ", attributes: [
            .font: UIFont(name: "SourceSansPro-Regular", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ,
            .paragraphStyle:style
        ]))
        }
        
        attributedString.append(NSAttributedString(string: "Edit Number".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Black", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(15)),
            .foregroundColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(140)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:))))
        return Label
    }()
    
    @objc func tapLabel(_ gesture: UITapGestureRecognizer) {
    guard let text = VerificationLabel.attributedText?.string else {return}

    guard let click_range = text.range(of: "Edit Number".localizable) else {return}
    if VerificationLabel.didTapAttributedTextInLabel(gesture: gesture, inRange: NSRange(click_range, in: text)) {
    self.Edit?.PhoneNumberTF.becomeFirstResponder()
    self.navigationController?.popViewController(animated: true)
    }
    }
    
    lazy var Number1TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number2TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number3TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number4TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var StackTF : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Number1TF,Number2TF,Number3TF,Number4TF])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(20)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return Stack
    }()

    lazy var ValidateButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Validate".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionValidate), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionValidate() {
    let Number = "\(random)"

    if let Number1 = Number1TF.text ,let Number2 = Number2TF.text ,let Number3 = Number3TF.text , let Number4 = Number4TF.text {
    let Text = Number1 + Number2 + Number3 + Number4
        
    if Text != Number || Text.count != 4 {
    Number1TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number2TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number3TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number4TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    
    UIView.animate(withDuration: 0.3) {
    self.IsnotCorrect.isHidden = false
    self.view.layoutIfNeeded()
    }
    
    }else{
    Number1TF.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    Number2TF.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    Number3TF.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    Number4TF.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    UIView.animate(withDuration: 0.3) {
    self.view.layoutIfNeeded()
    self.IsnotCorrect.isHidden = true
    }
        
    dismiss(animated: true)
    Edit?.ProfileSaveChanges()
    }
    }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
    let text = textField.text
            
    if let t: String = textField.text {
    textField.text = String(t.prefix(1))
    }
        
    if text?.count == 1 {
    switch textField {
    case Number1TF:
    Number2TF.becomeFirstResponder()
    case Number2TF:
        Number3TF.becomeFirstResponder()
    case Number3TF:
        Number4TF.becomeFirstResponder()
    case Number4TF:
        Number4TF.resignFirstResponder()
    default:
    break
    }
    }
    if text?.count == 0 {
    UIView.animate(withDuration: 0.3) {
    self.view.layoutIfNeeded()
    self.IsnotCorrect.isHidden = true
    }
    switch textField{
    case Number1TF:
        Number1TF.becomeFirstResponder()
    case Number2TF:
        Number1TF.becomeFirstResponder()
    case Number3TF:
        Number2TF.becomeFirstResponder()
    case Number4TF:
        Number3TF.becomeFirstResponder()
    default:
    break
    }
    }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    lazy var IsnotCorrect : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        Label.isHidden = true
        Label.backgroundColor = .clear
        Label.text = "OTP is not correct".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(15))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Label
    }()

    lazy var Labeltimer : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = false
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LabelTimerAction)))
        return Label
    }()
    
    @objc func LabelTimerAction() {
        StartTimer()
        VerificationSend()
    }

    var timer = Timer()
    var newTimer = 120
    @objc func ActionLabeltimer()  {
    let Timer = "lang".localizable == "ar" ? "\(timeFormatted(newTimer))".NumAR() : "\(timeFormatted(newTimer))" 
    newTimer -= 1
    AttributedString(Labeltimer, "The code will be resend in".localizable, Timer, "sec".localizable, NSMakeRange(0,Labeltimer.text?.count ?? 0)
                     ,#colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1))
    Labeltimer.isUserInteractionEnabled = false
    if newTimer < -1 {
    let Text = "Resend OTP".localizable
        
    AttributedString(Labeltimer, Text, "", "", NSMakeRange(0,Text.count)
                     ,#colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1))
    Labeltimer.isUserInteractionEnabled = true
    timer.invalidate()
    }
    }
    
    
    public func AttributedString(_ Label:UILabel,_ Text1:String,_ Text2:String,_ Text3:String,_ range: NSRange ,_ Color: UIColor) {
    let style = NSMutableParagraphStyle()
    style.alignment = .center
        
    let underlinedMessage = NSMutableAttributedString(string: Text1 + " ", attributes: [
    .font: UIFont(name: "SourceSansPro-Bold", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: Color,
    .paragraphStyle:style,
    .underlineStyle:NSUnderlineStyle.single.rawValue
    ])
    underlinedMessage.append(NSAttributedString(string: Text2 + " ", attributes: [
    .font: UIFont(name: "SourceSansPro-Bold" , size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: Color,
    .paragraphStyle:style
    ]))
    
    underlinedMessage.append(NSAttributedString(string: Text3, attributes: [
    .font: UIFont(name: "SourceSansPro-Bold", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: Color,
    .paragraphStyle:style,
    .underlineStyle:NSUnderlineStyle.single.rawValue
    ]))
        
    Label.attributedText = underlinedMessage
    }
    

    
    func StartTimer() {
    newTimer = 120
    timer = Timer.scheduledTimer(timeInterval: 1 , target: self , selector:  #selector(ActionLabeltimer) , userInfo: nil , repeats:  true)
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    

    let random = Int.random(in: 1000..<9999)
    func VerificationSend() {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    guard let edit = Edit else{return}
    guard let Phone = edit.PhoneNumberTF.text else{return}
            
    let Verification = "\(url + SendSms)"
    let token = defaults.string(forKey: "jwt") ?? ""

    let parameters:[String:Any] = ["Phone": Phone,
                                   "VerificationMessage": "\(random)"]
        
    PostAPI(api: Verification, token: token , parameters: parameters) { _ in
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    if error != "" {
    ShowMessageAlert("Error", "Error".localizable, error, false, self.VerificationSend)
    }
    }
    }
    
    
    lazy var ViewContent:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        View.layer.cornerRadius = ControlX(10)
        return View
    }()
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [VerificationLabel,StackTF,Labeltimer,IsnotCorrect,ValidateButton])
        Stack.axis = .vertical
        Stack.backgroundColor = .clear
        Stack.spacing = ControlX(5)
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var CloseButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setBackgroundImage(UIImage(named: "plus_icn_pink"), for: .normal)
        Button.addTarget(self, action: #selector(ActionClose), for: .touchUpInside)
        return Button
    }()
        
    @objc func ActionClose() {
      self.dismiss(animated: true)
    }

}
