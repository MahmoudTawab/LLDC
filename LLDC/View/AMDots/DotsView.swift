//
//  DotsView.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 30/12/2021.
//

import UIKit

var timeInterval = Double()
public enum AlertStyle {
    case success,error,warning,none
}


class DotsView: UIView {

    var ViewPresent:UIViewController?
    lazy var SpinnerView : Spinner = {
        let View = Spinner()
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(Background)
        Background.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        Background.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        Background.widthAnchor.constraint(equalTo:self.widthAnchor).isActive = true
        Background.heightAnchor.constraint(equalTo:self.heightAnchor).isActive = true
        
        addSubview(SpinnerView)
        SpinnerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        SpinnerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        SpinnerView.widthAnchor.constraint(equalToConstant: ControlWidth(160)).isActive = true
        SpinnerView.heightAnchor.constraint(equalToConstant: ControlWidth(160)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    lazy var Background:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    func endRefreshing(_ Title:String = "" ,_ AlertStyle: AlertStyle = .none ,_ completion: @escaping (() -> Void)) {
        if DotsShow {
        DotsShow = false
        self.DotsTimer.invalidate()
        UIView.animate(withDuration: 0.5) {
        self.SpinnerView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.alpha = 0
        } completion: { (_) in
        self.SpinnerView.stopAnimating()
        
        if topViewController(self.ViewPresent) != topViewController(PopUpCenterView()) {
        let Controller = PopUpCenterView()
        Controller.MessageDetails = Title
        Controller.StackIsHidden = false
        Controller.RightButton.isHidden = true
            
        Controller.modalPresentationStyle = .overFullScreen
        Controller.modalTransitionStyle = .crossDissolve
        
        if AlertStyle == .error {
        Controller.ImageIcon = "Error"
        Controller.MessageTitle = "Error".localizable
        self.ViewPresent?.present(Controller, animated: true, completion: nil)
        }else if AlertStyle == .success {
        Controller.ImageIcon = "Successfully"
        Controller.MessageTitle = "Success".localizable
        self.ViewPresent?.present(Controller, animated: true, completion: nil)
        }else if AlertStyle == .warning {
        Controller.ImageIcon = "Error"
        Controller.MessageTitle = "Warning".localizable
        self.ViewPresent?.present(Controller, animated: true, completion: nil)
        }
            
        completion()
        }
        }
        }
    }
    
    var DotsShow = false
    var DotsTimer = Timer()
    func beginRefreshing() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
    if !self.DotsShow {
    self.DotsShow = true
    self.SpinnerView.startAnimating()
    self.DotsTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.TimedOut), userInfo: self, repeats: false)
    UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
    self.SpinnerView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
    self.alpha = 1
    self.SpinnerView.transform = .identity
    })
    }
    }
    }
    
    @objc func TimedOut() {
    if topViewController(self.ViewPresent) != topViewController(PopUpCenterView()) {
    if DotsShow {
    DotsShow = false
    self.DotsTimer.invalidate()
    UIView.animate(withDuration: 0.5) {
    self.SpinnerView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    self.alpha = 0
    } completion: { (_) in
    self.SpinnerView.stopAnimating()

    let Controller = PopUpCenterView()
    Controller.MessageTitle = "Error".localizable
    Controller.ImageIcon = "Error"
    Controller.StackIsHidden = false
    Controller.RightButton.isHidden = true
    Controller.MessageDetails = "The request timed out.".localizable

    Controller.modalPresentationStyle = .overFullScreen
    Controller.modalTransitionStyle = .crossDissolve
    self.ViewPresent?.present(Controller, animated: true, completion: nil)
    }
    }
    }
    }
}


