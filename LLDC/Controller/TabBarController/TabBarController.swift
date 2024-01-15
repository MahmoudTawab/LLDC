//
//  TabBarController.swift
//  LLDC
//
//  Created by Emojiios on 29/03/2022.
//

import UIKit

@available(iOS 9.0, *)
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
   @IBInspectable var selectedTab : Int = 0 {
    didSet{
    selectedIndex = selectedTab
    }
    }
    
    private var buttons = [UIButton]()
    private var indexViewCenterXAnchor: NSLayoutConstraint!

    private let customTabBarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let indexView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override var viewControllers: [UIViewController]? {
        didSet {
            createButtonsStack(viewControllers!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        setupViewController()
        addcoustmeTabBarView()
        createButtonsStack(viewControllers!)
        self.selectedIndex = selectedTab
        autolayout()
        
        indexView.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        indexView.layer.shadowColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        customTabBarView.layer.cornerRadius = ControlX(25)
        indexView.layer.cornerRadius = ControlX(1.5)
    }
    
    fileprivate func setupViewController() {
    let Home = setupNavigationController(HomeVC(), "Home", "HomeSelected")

    let Areas = setupNavigationController(ExploreAreasVC(), "Areas", "AreasSelected")

    let Notification = setupNavigationController(NotificationVC(), "Notification", "NotificationSelected")

    let Menu = setupNavigationController(MenuVC(), "Menu", "MenuSelected")

    viewControllers = [Home,Areas,Notification,Menu]
    }

    var image = [UIImage?]()
    var ImageSelected = [UIImage?]()
    fileprivate func setupNavigationController(_ viewController:UIViewController ,_ Image:String ,_ SelectedImage:String) -> UINavigationController {
    let ControllerNav = UINavigationController(rootViewController: viewController)
    ControllerNav.navigationBar.isHidden = true

    image.append(UIImage(named: Image))
    ImageSelected.append(UIImage(named: SelectedImage))
    return ControllerNav
    }

    
    private func createButtonsStack(_ viewControllers: [UIViewController]) {
        
        // clean :
        buttons.removeAll()
        
        stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        for (index, _) in viewControllers.enumerated() {
           
            let button = UIButton()
            button.tag = index
            button.addTarget(self, action: #selector(didSelectIndex(sender:)), for: .touchUpInside)
            let image = index == 0 ? ImageSelected[index] : image[index]
            button.imageView?.tintColor = .black
            button.setImage(image, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        view.setNeedsLayout()

    }
    
    private func autolayout() {
        customTabBarView.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        customTabBarView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor,constant: ControlX(15)).isActive = true
        customTabBarView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor,constant: ControlX(-15)).isActive = true
        customTabBarView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor,constant: ControlX(-20)).isActive = true
        stackView.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: customTabBarView.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: customTabBarView.heightAnchor).isActive = true
        indexView.heightAnchor.constraint(equalToConstant: ControlWidth(3)).isActive = true
        indexView.widthAnchor.constraint(equalToConstant: customTabBarView.bounds.height - ControlX(5)).isActive = true
        indexView.bottomAnchor.constraint(equalTo: customTabBarView.bottomAnchor,constant: ControlX(-6)).isActive = true
        
        indexViewCenterXAnchor = indexView.centerXAnchor.constraint(equalTo: buttons[selectedTab].centerXAnchor)
        indexViewCenterXAnchor.isActive = true
    }
    
    private func addcoustmeTabBarView() {
        tabBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: ControlWidth(70))
        customTabBarView.frame = CGRect(x: ControlX(15), y: ControlX(15), width: tabBar.frame.width - ControlX(20), height: ControlWidth(50))
        indexView.frame = CGRect(x: 0, y: customTabBarView.frame.maxY - ControlX(6), width: customTabBarView.bounds.height - ControlX(5), height: ControlWidth(3))
        
        view.bringSubviewToFront(self.tabBar)
        tabBar.addSubview(customTabBarView)
        customTabBarView.addSubview(indexView)
        customTabBarView.addSubview(stackView)
    }
    
    
    @objc private func didSelectIndex(sender: UIButton) {
        let index = sender.tag
        self.selectedIndex = index
        self.selectedTab = index
        
        for (indx, button) in self.buttons.enumerated() {
            if indx != index {
                button.setImage(image[indx], for: .normal)
            } else {
                button.setImage(ImageSelected[indx], for: .normal)
            }
        }
        
        self.indexView.alpha = 0.5
        UIView.transition(from: view, to: view, duration: 0.2, options: [.transitionCrossDissolve,.showHideTransitionViews])
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.indexView.alpha = 1
            self.indexViewCenterXAnchor.isActive = false
            self.indexViewCenterXAnchor = nil
            self.indexViewCenterXAnchor = self.indexView.centerXAnchor.constraint(equalTo: self.buttons[index].centerXAnchor)
            self.indexViewCenterXAnchor.isActive = true
            self.tabBar.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    // Delegate:
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard
            let items = tabBar.items,
            let index = items.firstIndex(of: item)
            else {
                print("not found")
                return
        }
        didSelectIndex(sender: self.buttons[index])
    }
    
    init() {
    super.init(nibName: nil, bundle: nil)
    object_setClass(self.tabBar, WeiTabBar.self)
    }

    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    
}


class WeiTabBar: UITabBar {
      override func sizeThatFits(_ size: CGSize) -> CGSize {
          var sizeThatFits = super.sizeThatFits(size)
          sizeThatFits.height = ControlWidth(70)
        
          self.clipsToBounds = false
          self.layer.masksToBounds = false
          self.backgroundColor = .clear
          self.shadowImage = UIImage()
          self.backgroundImage = UIImage()
          self.tintColor = .clear
          self.barTintColor = .clear
          self.unselectedItemTintColor = .clear
          return sizeThatFits
      }
  }
