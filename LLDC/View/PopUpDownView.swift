//
//  PopUpDownView.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 24/07/2021.
//

import UIKit

enum State {
    case closed
    case open
}

extension State {
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}

class PopUpDownView: ViewController {
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .clear
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = view.bounds
        ViewScroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        ViewScroll.addSubview(ViewDismiss)
        ViewDismiss.frame = view.bounds
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        UIView.animate(withDuration: 0.7) {
        self.ViewDismiss.backgroundColor = UIColor(red: 17/255, green: 12/255, blue: 9/255, alpha: 0.25)
        }
        }
        
        ViewScroll.addSubview(View)
        View.frame = CGRect(x: 0, y: view.frame.maxY - endCardHeight, width: view.frame.width, height: ControlHeight(endCardHeight))
        
        View.roundCorners(corners: [.topLeft, .topRight], radius: ControlHeight(radius), fillColor: UIColor.white.cgColor)
    }
    
    lazy var View: UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        View.layer.shadowOpacity = 0.6
        View.layer.shadowOffset = CGSize(width: 1, height: -1)
        View.layer.shadowRadius = 10
        View.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:))))
        return View
    }()
    
    lazy var ViewDismiss : UIView = {
        let View = UIView()
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DismissAction)))
        return View
    }()
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.bounces = false
        return Scroll
    }()

    var radius:CGFloat = 0
    var endCardHeight:CGFloat = 0
    var startCardHeight:CGFloat = 0
    var runningAnimations = [UIViewPropertyAnimator]()
    
    var currentState: State = .closed
    private var animationProgress = [CGFloat]()
    @objc func handleCardPan (recognizer:UIPanGestureRecognizer) {
    switch recognizer.state {
    case .began:
    animateTransitionIfNeeded(state: currentState.opposite, duration:  0.9)
    runningAnimations.forEach { $0.pauseAnimation() }
    animationProgress = runningAnimations.map { $0.fractionComplete }
    case .changed:
    let translation = recognizer.translation(in: View)
    var fraction = -translation.y / endCardHeight
    if currentState == .open { fraction *= -1 }
    if runningAnimations[0].isReversed { fraction *= -1 }

    for (index, animator) in runningAnimations.enumerated() {
    animator.fractionComplete = fraction + animationProgress[index]
    }
    case .ended:
    let translation = recognizer.translation(in: View)
    let Y =  endCardHeight - translation.y

    if Y > (self.endCardHeight / 2) {
    runningAnimations.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
    runningAnimations.forEach { $0.isReversed = !$0.isReversed }
    }else{
    runningAnimations.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
    runningAnimations.forEach { $0.isReversed = $0.isReversed }
    }
    
    default:
    break
    }
    }
    
    func animateTransitionIfNeeded (state:State, duration:TimeInterval) {
    guard runningAnimations.isEmpty else { return }
        
    let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.9) {
    switch state {
    case .open:
    self.View.frame.origin.y = self.view.frame.height - self.endCardHeight
    
    case .closed:
    self.View.frame.origin.y = self.view.frame.height - self.startCardHeight
    }
    }
        
    frameAnimator.addCompletion { position in
    switch position {
    case .start:
    self.currentState = state.opposite
    case .end:
    self.currentState = state
    case .current:
    ()
    default:
    break
    }
        
    switch self.currentState {
    case .open:
    self.View.frame.origin.y = self.view.frame.height - self.endCardHeight
    case .closed:
    self.View.frame.origin.y = self.view.frame.height - self.startCardHeight
    self.dismiss(animated: false)
    }

    self.runningAnimations.removeAll()
    }
    
    frameAnimator.startAnimation()
    runningAnimations.append(frameAnimator)
    let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
    switch state {
    case .open:
    self.View.layer.cornerRadius = ControlHeight(25)
    self.ViewDismiss.backgroundColor = UIColor(red: 17/255, green: 12/255, blue: 9/255, alpha: 0.25)
    case .closed:
    self.View.layer.cornerRadius = ControlHeight(5)
    self.ViewDismiss.backgroundColor = UIColor(red: 17/255, green: 12/255, blue: 9/255, alpha: 0)
    }
    }
    cornerRadiusAnimator.startAnimation()
    runningAnimations.append(cornerRadiusAnimator)
    }
    
    @objc func DismissAction() {
    UIView.animate(withDuration: 0.4) {
    self.ViewDismiss.backgroundColor = UIColor(red: 17/255, green: 12/255, blue: 9/255, alpha: 0)
    self.View.frame = CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.width, height: self.endCardHeight)
    } completion: { (_) in
    self.dismiss(animated: false)
    }
    }
}
