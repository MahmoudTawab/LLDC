//
//  BecomeMemberVC.swift
//  LLDC
//
//  Created by Emojiios on 31/03/2022.
//

import UIKit

class BecomeMemberVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
 
        let TopHeight = UIApplication.shared.statusBarFrame.height
        ViewScroll.frame = CGRect(x: 0, y: -TopHeight, width: view.frame.width, height: view.frame.height + TopHeight)
        view.addSubview(ViewScroll)
        
        ViewScroll.addSubview(TopView)
        TopView.frame = CGRect(x: 0, y: 0 , width: view.frame.width, height: ControlWidth(260))
        
        ViewScroll.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
    
        TopView.addSubview(TopImage)
        TopImage.frame = CGRect(x: ControlX(60), y: ControlY(50) , width: TopView.frame.width - ControlX(110), height: TopView.frame.height - ControlY(70))
        
        let Color = #colorLiteral(red: 0.9029068351, green: 0.9106900096, blue: 0.840657115, alpha: 1).cgColor
        TopView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: ControlY(10), fillColor: Color)
        
        ViewScroll.addSubview(StackLabel)
        StackLabel.frame = CGRect(x: ControlX(15), y: TopView.frame.maxY + ControlY(25), width: view.frame.width - ControlX(30), height: ControlWidth(60))
        
        ViewScroll.addSubview(MessageTV)
        let HeightMessage = text.TextHeight(view.frame.width - ControlX(30), font: UIFont.systemFont(ofSize: ControlWidth(16)), Spacing: ControlX(6))
        MessageTV.frame = CGRect(x: ControlX(15), y: StackLabel.frame.maxY + ControlY(10), width: view.frame.width - ControlX(30), height: HeightMessage ?? 0)
        
        ViewScroll.addSubview(BecomeMember)
        BecomeMember.frame = CGRect(x: ControlX(15), y: MessageTV.frame.maxY + ControlY(25), width: view.frame.width - ControlX(30), height: ControlWidth(50))
        
        ViewScroll.addSubview(CardDetails)
        CardDetails.frame = CGRect(x: ControlX(15), y: BecomeMember.frame.maxY + ControlY(25), width: view.frame.width - ControlX(30), height: ControlWidth(330))
        
        CardDetails.addSubview(CardDetailsLabel)
        CardDetailsLabel.frame = CGRect(x: ControlX(15), y: ControlX(15), width: CardDetails.frame.width - ControlX(30), height: ControlWidth(30))
        
        CardDetails.addSubview(StackCardDetails)
        StackCardDetails.frame = CGRect(x: ControlX(15), y: ControlX(60), width: CardDetails.frame.width - ControlX(30), height: CardDetails.frame.height - ControlX(80))
        
        ViewScroll.updateContentViewSize(ControlX(20))
    }
    
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.bounces = false
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        return Scroll
    }()
    
    lazy var TopView:UIView = {
        let View = UIView()
        return View
    }()
    
    lazy var TopImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleToFill
        ImageView.image = UIImage(named: "ScreenShot")
        return ImageView
    }()

    lazy var BecomeVIPMember : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(10)
        
        let attributedString = NSMutableAttributedString(string: "Become VIP member".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Black", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "The benefits", attributes: [
            .font: UIFont(name: "SourceSansPro-Regular", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
            .foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        return Label
    }()

    lazy var PriceLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(20))
        Label.widthAnchor.constraint(equalToConstant: ControlWidth(85)).isActive = true
        Label.text = "lang".localizable == "ar" ? "4000 \("EGP".localizable)".NumAR() : "4000 \("EGP".localizable)"
        return Label
    }()

    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [BecomeVIPMember,PriceLabel])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()

    let text = "•   Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et • dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita • kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur • sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam •   Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et • dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita • kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur • sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam "
    lazy var  MessageTV : UITextView = {
        let TV = UITextView()
        TV.text = text
        TV.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        TV.isEditable = false
        TV.tintColor = .clear
        TV.isSelectable = false
        TV.spasing = ControlX(6)
        TV.isScrollEnabled = false
        TV.backgroundColor = .clear
        TV.autocorrectionType = .no
        TV.font = UIFont(name: "SourceSansPro-Regular", size:  ControlWidth(16))
        TV.textContainerInset = UIEdgeInsets(top: 5, left: -4, bottom: 0, right: 0)
        return TV
    }()
    
    lazy var BecomeMember : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Become VIP member".localizable, for: .normal)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionBecomeMember), for: .touchUpInside)
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()

    @objc func ActionBecomeMember() {
    ShowMessageAlert("Successfully".localizable, "Success".localizable, "SuccessScreenShotMessage".localizable, true) {}
    }
    
    lazy var CardDetails : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.cornerRadius = ControlX(10)
        return View
    }()
    
    lazy var StackCardDetails : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [CardholderNameTF,CardNumberTF,StackTF,TotalStack])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(6)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var CardDetailsLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Card Details".localizable
        Label.font = UIFont(name: "SourceSansPro-Semibold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var CardholderNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Cardholder name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var CardNumberTF : FloatingTF = {
        let tf = FloatingTF()
        tf.keyboardType = .numberPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Card number".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var StackTF : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ExpiryDateTF,CVVTF])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        return Stack
    }()

    lazy var ExpiryDateTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = .clear
        tf.ShowError = false
        tf.addTarget(self, action: #selector(ActionExpiryDate), for: .editingDidBegin)
        tf.Icon.addTarget(self, action: #selector(ActionExpiryDate), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionExpiryDate)))
        tf.attributedPlaceholder = NSAttributedString(string: "Expiry Date".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    
    let DatePicker = UIDatePicker()
    @objc func ActionExpiryDate() {
        let PopUp = PopUpDownView()
        PopUp.currentState = .open
        PopUp.modalPresentationStyle = .overFullScreen
        PopUp.modalTransitionStyle = .coverVertical
        PopUp.endCardHeight = ControlWidth(240)
        PopUp.radius = 25

        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.text = "Expiry Date".localizable
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(20))
        PopUp.View.addSubview(Label)
        Label.frame = CGRect(x: ControlX(20), y: ControlY(15), width: PopUp.view.frame.width - ControlX(40), height: ControlWidth(30))
            
        DatePicker.minimumDate = Date()
        DatePicker.datePickerMode = .date
        DatePicker.backgroundColor = .white
        DatePicker.locale = Locale(identifier: "lang".localizable)
        if #available(iOS 13.4, *) {DatePicker.preferredDatePickerStyle = .wheels} else {}
        
        DatePicker.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        DatePicker.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        DatePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        PopUp.View.addSubview(DatePicker)
        DatePicker.frame = CGRect(x: ControlX(20), y: Label.frame.maxY + ControlY(5), width: PopUp.view.frame.width - ControlX(40), height: ControlWidth(180))
        present(PopUp, animated: true)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
    ExpiryDateTF.text = DatePicker.date.Formatter("yyyy/MM/dd")
    }
    
    lazy var CVVTF : FloatingTF = {
        let tf = FloatingTF()
        tf.keyboardType = .numberPad
        tf.attributedPlaceholder = NSAttributedString(string: "CVV".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var TotalStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TotalLabel,ButtonSubmit])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Stack
    }()
    
    lazy var TotalLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(10)
        
        let attributedString = NSMutableAttributedString(string: "Total".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Black", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        let Total = "lang".localizable == "ar" ? "4000 \("EGP".localizable)".NumAR():"4000 \("EGP".localizable)"
        attributedString.append(NSAttributedString(string: Total, attributes: [
            .font: UIFont(name: "SourceSansPro-Regular", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        return Label
    }()
    
    lazy var ButtonSubmit : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Submit".localizable, for: .normal)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionSubmit), for: .touchUpInside)
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()

    @objc func ActionSubmit() {
    ShowMessageAlert("Successfully".localizable, "Success".localizable, "SuccessScreenShotMessage".localizable, true) {}
    }

}
