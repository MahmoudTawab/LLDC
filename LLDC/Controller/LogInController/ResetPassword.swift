//
//  ResetPassword.swift
//  LLDC
//
//  Created by Emojiios on 28/03/2022.
//

import UIKit
import FirebaseAuth

class ResetPassword: ViewController {
    
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
        
        ViewScroll.addSubview(Dismiss)
        Dismiss.frame = CGRect(x: ControlX(15), y: ControlY(40), width: view.frame.width - ControlX(30), height: ControlHeight(40))
        
        ViewScroll.addSubview(StackItems)
        StackItems.frame = CGRect(x: ControlX(30), y: ImageLogo.frame.maxY + ControlY(20), width: view.frame.width - ControlX(60), height: ControlHeight(240))
        
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
    
    lazy var ResetLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(5)
        
        let attributedString = NSMutableAttributedString(string: "Forgot your password".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Black", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "Reset password Message".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Regular", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        return Label
    }()
    
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsEmail
        tf.keyboardType = .emailAddress
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Email".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var ContinueReset : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Reset Password".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionContinue), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionContinue() {
    if EmailTF.NoError() && EmailTF.NoErrorEmail() {
    guard let email = EmailTF.text else { return }
    self.ViewDots.beginRefreshing()
    Auth.auth().sendPasswordReset(withEmail: email) { (err) in
    if let err = err {
    self.ViewDots.endRefreshing() {ShowMessageAlert("Error", "Error".localizable, err.localizedDescription, false,self.ActionContinue)}
    return
    }
        
    self.ViewDots.endRefreshing() {
    self.EmailTF.text = ""
    ShowMessageAlert("Successfully", "Password Reset link".localizable, "Password reset link has been successfully sent to your email".localizable, true) {}
    }
    }
    }
    }

    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ResetLabel,EmailTF,ContinueReset])
        Stack.axis = .vertical
        Stack.backgroundColor = .clear
        Stack.spacing = ControlHeight(25)
        Stack.distribution = .equalSpacing
        return Stack
    }()

}
