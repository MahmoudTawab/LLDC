//
//  BookConfirmationQr.swift
//  LLDC
//
//  Created by Emojiios on 21/06/2022.
//

import UIKit
import SDWebImage

class BookConfirmationQr: UIViewController {
    
    @IBInspectable var QrTitle:String = "" {
      didSet {
        QrName.text = QrTitle
      }
    }
    
    @IBInspectable var QrImage:String = "" {
      didSet {
        IconImage.sd_setImage(with: URL(string: QrImage), placeholderImage: UIImage(named: "IconQR"))
      }
    }
    
    var ReservationData : ReservationsDetails? {
        didSet {
        guard let data = ReservationData else { return }
         
        PlaceName.text = data.placeName ?? ""
        LocationLabel.TextLabel = data.areaName ?? ""
        PriceLabel.TextLabel = "\(data.totalBookingFees ?? 0.0)"
        DateLabel.TextLabel = data.date ?? ""
        TimeLabel.TextLabel = data.time ?? ""
        }
    }
    
    
    @IBInspectable var CancelIsHidden:Bool = true {
      didSet {
          
      }
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    SetUp()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    UIView.animate(withDuration: 0.5, animations: {
      self.Background.frame = CGRect(x: ControlX(15), y: self.view.frame.maxY, width: self.view.frame.width - ControlX(30), height: self.Background.frame.height)
    }) { (End) in
    self.Background.transform = .identity
    }
    }
    
    func SetUp() {
      view.addSubview(DismissView)
      DismissView.frame = view.bounds
        
      view.addSubview(Background)
      Background.addSubview(Dismiss)
      Background.addSubview(IconImage)
      Background.addSubview(QrName)
      Background.addSubview(StackVertical)
      CancelButton.isHidden = CancelIsHidden
        
      let height = CancelIsHidden == false ? ControlWidth(460) : ControlWidth(400)
      Background.frame = CGRect(x: ControlX(15), y: view.frame.maxY, width: view.frame.width - ControlX(30), height: height)
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.65, options: []) {
      self.Background.frame = CGRect(x: ControlX(15), y: self.view.center.y - (height / 2), width: self.view.frame.width - ControlX(30), height: height)
      }
      }
        
      self.Dismiss.frame = CGRect(x: self.Background.frame.width - ControlWidth(50), y: ControlWidth(10), width: ControlWidth(40), height: ControlWidth(40))
        
      IconImage.centerXAnchor.constraint(equalTo: Background.centerXAnchor).isActive = true
      IconImage.topAnchor.constraint(equalTo: Dismiss.bottomAnchor).isActive = true
      IconImage.widthAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
      IconImage.heightAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        
      QrName.topAnchor.constraint(equalTo: IconImage.bottomAnchor, constant: ControlX(20)).isActive = true
      QrName.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: ControlX(30)).isActive = true
      QrName.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: ControlX(-30)).isActive = true
      QrName.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
      StackVertical.leadingAnchor.constraint(equalTo: QrName.leadingAnchor).isActive = true
      StackVertical.trailingAnchor.constraint(equalTo: QrName.trailingAnchor).isActive = true
      StackVertical.topAnchor.constraint(equalTo: QrName.bottomAnchor, constant: ControlX(15)).isActive = true
      StackVertical.heightAnchor.constraint(equalToConstant: height - ControlWidth(220)).isActive = true
    }
    
    
    lazy var DismissView : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionDismiss)))
        return View
    }()

    lazy var Background:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
        View.layer.cornerRadius = ControlX(10)
        return View
    }()

    lazy var IconImage:UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = .black
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFit
        ImageView.image = UIImage(named: "IconQR")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var QrName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()

    lazy var PlaceName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.1097276457, green: 0.1182126865, blue: 0.1300852455, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(18))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Label
    }()
    
    lazy var LocationLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "Location"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(15))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(13))
        return View
    }()
    
    lazy var PriceLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "Group 31381"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(12))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(14))
        return View
    }()
        
    lazy var DateLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "calendar"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(13), height: ControlHeight(13))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(13))
        return View
    }()
    
    lazy var TimeLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.backgroundColor = .clear
        View.IconImage.setImage(UIImage(named: "clock"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(12), height: ControlHeight(12))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(13))
        return View
    }()
    
    lazy var LocationPrice : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LocationLabel,PriceLabel])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(5)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var DateTime : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [DateLabel,TimeLabel])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(5)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
          
    lazy var StackLabel : UIStackView = {
      let Stack = UIStackView(arrangedSubviews: [PlaceName,LocationPrice,DateTime])
      Stack.axis = .vertical
      Stack.spacing = ControlX(10)
      Stack.distribution = .fillEqually
      Stack.alignment = .fill
      Stack.backgroundColor = .clear
      Stack.translatesAutoresizingMaskIntoConstraints = false
      Stack.heightAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
      return Stack
    }()
    
    lazy var StackButton : UIStackView = {
      let Stack = UIStackView(arrangedSubviews: [ShareButton,CancelButton])
      Stack.axis = .vertical
      Stack.spacing = ControlX(20)
      Stack.distribution = .fillEqually
      Stack.alignment = .fill
      Stack.backgroundColor = .clear
      Stack.translatesAutoresizingMaskIntoConstraints = false
      Stack.heightAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
      return Stack
    }()
    
    lazy var StackVertical : UIStackView = {
      let Stack = UIStackView(arrangedSubviews: [StackLabel,StackButton])
      Stack.axis = .vertical
      Stack.distribution = .equalSpacing
      Stack.alignment = .fill
      Stack.backgroundColor = .clear
      Stack.translatesAutoresizingMaskIntoConstraints = false
      return Stack
    }()
      
    lazy var ShareButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.layer.cornerRadius = ControlX(10)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setTitle("Share Qr Code".localizable, for: .normal)
        Button.addTarget(self, action: #selector(ShareQR), for: .touchUpInside)
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(15))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ShareQR() {
    if let logo = IconImage.image, let websiteURL = URL(string: QrImage) {
    let objectsToShare = [logo,"LLDC", websiteURL] as [Any]
    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
    if let popoverController = activityVC.popoverPresentationController {
    popoverController.sourceView = self.view
    popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
    }
    present(activityVC, animated: true)
    }
    }
      
      lazy var CancelButton : UIButton = {
          let Button = UIButton(type: .system)
          Button.backgroundColor = .clear
          Button.layer.borderColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
          Button.layer.borderWidth = ControlX(1)
          Button.layer.cornerRadius = ControlX(10)
          Button.translatesAutoresizingMaskIntoConstraints = false
          Button.setTitle("Cancel reservation".localizable, for: .normal)
          Button.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
          Button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(15))
          Button.setTitleColor(#colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1), for: .normal)
          return Button
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
