//
//  Present.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit

class ViewController : UIViewController  {
        
    let TopHeight = UIApplication.shared.statusBarFrame.height
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    ViewNoData.removeFromSuperview()
    ViewDots.removeFromSuperview()
    view.addSubview(ViewNoData)
    view.addSubview(ViewDots)
    self.ViewDots.SpinnerView.startAnimating()
        
    ViewNoData.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlWidth(20)).isActive = true
    ViewNoData.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlWidth(-20)).isActive = true
    ViewNoData.topAnchor.constraint(equalTo: view.topAnchor, constant: self.hidesBottomBarWhenPushed != true ? ControlWidth(110):ControlWidth(150)).isActive = true
    ViewNoData.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: self.hidesBottomBarWhenPushed != true ? ControlWidth(-130):ControlWidth(-100)).isActive = true
    }
    
    lazy var Dismiss : ImageAndLabel = {
        let dismiss = ImageAndLabel()
        dismiss.backgroundColor = .clear
        dismiss.IconImage.transform = "lang".localizable == "ar" ? CGAffineTransform(rotationAngle: .pi) : .identity
        dismiss.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return dismiss
    }()
    
    @objc func ActionDismiss() {
      self.navigationController?.popViewController(animated: true)
    }

    
    lazy var ViewDots : DotsView = {
        let View = DotsView(frame: view.bounds)
        View.backgroundColor = .clear
        View.ViewPresent = self
        View.alpha = 0
        return View
    }()
    
    lazy var ViewNoData : ViewIsError = {
        let View = ViewIsError()
        View.backgroundColor = .clear
        View.isHidden = true
        View.ImageIcon = "ErrorService"
        View.TextRefresh = "Try Again".localizable
        View.MessageTitle = "Something went wrong".localizable
        View.MessageDetails = "Something went wrong while processing your request, please try again later".localizable
        View.translatesAutoresizingMaskIntoConstraints =  false
        return View
    }()
    
    var ViewNoDataShow = false
    func SetUpIsError(_ error:String ,_ Show:Bool ,_ selector: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.ViewDots.endRefreshing(){}
        }
        
        if !ViewNoDataShow {
        if Show {
        self.ViewNoDataShow = true
        self.ViewNoData.isHidden = false
        self.ViewNoData.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
        self.ViewNoData.transform = .identity})
        self.ViewNoData.RefreshButton.addAction(for: .touchUpInside) { (button) in
        selector()
        }
        }
        }
    }

}

