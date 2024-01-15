//
//  AnnouncementVC.swift
//  LLDC (iOS)
//
//  Created by Emoji Technology on 08/08/2021.
//

import UIKit

class AnnouncementVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    SetUp()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    UIView.animate(withDuration: 0.5, animations: {
      self.ViewPop.frame = CGRect(x: ControlX(15), y: self.view.frame.maxY, width: self.view.frame.width - ControlX(30), height: self.ViewPop.frame.height)
    }) { (End) in
    self.ViewPop.transform = .identity
    }
    }
    
   
    func SetUp() {
    
        guard let DetailHeight = MessageText.TextHeight(view.frame.width - ControlX(60), font: UIFont.boldSystemFont(ofSize:ControlWidth(16)), Spacing: ControlWidth(6)) else{return}
        
       let Height = DetailHeight < (view.frame.height / 2) ? DetailHeight:(view.frame.height / 2)
       let height = Height + ControlWidth(90)
            
        view.addSubview(ViewPop)
        ViewPop.frame = CGRect(x: ControlX(15), y: view.frame.maxY, width: view.frame.width - ControlX(30), height: height)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.65, options: []) {
        self.ViewPop.frame = CGRect(x: ControlX(15), y: self.view.center.y - (height / 2), width: self.view.frame.width - ControlX(30), height: height)
        }
        }
                
        Message.frame = CGRect(x: ControlX(15), y: ControlX(30), width: ViewPop.frame.width - ControlX(30), height: Height + ControlX(15))
        ViewPop.addSubview(Message)
        
        var topCorrection = (Message.bounds.size.height - Message.contentSize.height * Message.zoomScale) / 2.0
        topCorrection = max(0, topCorrection)
        Message.contentInset = UIEdgeInsets(top: topCorrection , left: -4, bottom: 0, right: 4)
            
        Dismiss.frame = CGRect(x: ViewPop.frame.width - ControlWidth(45), y: ControlX(5), width: ControlWidth(35), height: ControlWidth(35))
        ViewPop.addSubview(Dismiss)
        
        ReadableView.frame = CGRect(x: ControlX(15), y: Message.frame.maxY + ControlX(10), width: ControlWidth(10), height: ControlWidth(10))
        ReadableView.layer.cornerRadius = ControlX(5)
        ViewPop.addSubview(ReadableView)
      
        LabelDate.frame = CGRect(x: ReadableView.frame.maxX + ControlX(10), y: Message.frame.maxY + ControlX(5), width: ViewPop.frame.width - ControlWidth(50), height: ControlWidth(20))
        ViewPop.addSubview(LabelDate)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    lazy var ViewPop : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        View.layer.cornerRadius = ControlX(12)
        return View
    }()    

    @IBInspectable var MessageText:String = "" {
      didSet {
        Message.text = MessageText
        Message.spasing = ControlWidth(6)
      }
    }
    
    lazy var Message : UITextView = {
        let TV = UITextView()
        TV.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        TV.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        TV.isEditable = false
        TV.backgroundColor = .clear
        TV.keyboardAppearance = .light
        TV.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(16))
        TV.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        return TV
    }()

    lazy var LabelDate : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(13))
        return Label
    }()
    
    lazy var ReadableView:UIView = {
        let View = UIView()
        return View
    }()
    
    lazy var Dismiss : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Button.backgroundColor = .clear
        Button.setBackgroundImage(UIImage(named: "plus_icn_pink"), for: .normal)
        Button.addTarget(self, action: #selector(ActionDismiss), for: .touchUpInside)
        return Button
    }()
        
    @objc func ActionDismiss() {
      self.dismiss(animated: true)
    }
    
    
}
