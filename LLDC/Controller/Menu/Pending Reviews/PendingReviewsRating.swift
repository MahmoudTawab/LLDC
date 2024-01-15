//
//  PendingReviewsRating.swift
//  LLDC
//
//  Created by Emojiios on 03/04/2022.
//

import UIKit

class PendingReviewsRating: ViewController {

    var PlacesId:String?
    var canEdit = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Dismiss.TextLabel = "Pending Reviews".localizable
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: 0, y: Dismiss.frame.maxY + ControlY(15) , width: view.frame.width, height: view.frame.height - (Dismiss.frame.maxY + ControlY(15)))

        
        ViewScroll.addSubview(ViewTop)
        ViewTop.frame = CGRect(x: ControlX(15), y: 0 , width: view.frame.width - ControlX(30), height: ControlWidth(140))
        
        ViewTop.addSubview(ImageRating)
        ImageRating.frame = CGRect(x: 0, y: 0, width: ControlWidth(160), height: ViewTop.frame.height)
        
        ViewTop.addSubview(ImageRating)
        ImageRating.frame = CGRect(x: 0, y: 0, width: ControlWidth(120), height: ViewTop.frame.height)
        
        ViewTop.addSubview(StackLabel)
        StackLabel.frame = CGRect(x: ImageRating.frame.maxX + ControlX(10), y: ControlX(10), width: ViewTop.frame.width - ControlX(140), height: ViewTop.frame.height - ControlX(20))
        
        ViewScroll.addSubview(StackRating)
        StackRating.frame = CGRect(x: ControlX(15), y: StackLabel.frame.maxY + ControlX(30), width: view.frame.width - ControlX(30), height: ControlWidth(240))
        
        ViewScroll.addSubview(TextView)
        TextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
        TextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        TextView.topAnchor.constraint(equalTo: StackRating.bottomAnchor, constant: ControlX(25)).isActive = true
        TextView.heightAnchor.constraint(equalToConstant: ControlWidth(150)).isActive = true
      
        ViewScroll.addSubview(ViewLine)
        ViewLine.bottomAnchor.constraint(equalTo: TextView.bottomAnchor).isActive = true
        ViewLine.leadingAnchor.constraint(equalTo: TextView.leadingAnchor).isActive = true
        ViewLine.trailingAnchor.constraint(equalTo: TextView.trailingAnchor).isActive = true
        ViewLine.heightAnchor.constraint(equalToConstant: ControlX(1)).isActive = true

        ViewScroll.addSubview(AddReview)
        AddReview.leadingAnchor.constraint(equalTo: TextView.leadingAnchor).isActive = true
        AddReview.trailingAnchor.constraint(equalTo: TextView.trailingAnchor).isActive = true
        AddReview.topAnchor.constraint(equalTo: TextView.bottomAnchor, constant: ControlY(35)).isActive = true
        AddReview.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        ViewScroll.updateContentViewSize(ControlX(30))
    }
    
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        return Scroll
    }()
    
    lazy var ViewTop:UIView = {
        let View = UIView()
        View.layer.shadowRadius = 4
        View.layer.shadowOpacity = 0.4
        View.backgroundColor = .white
        View.layer.shadowOffset = .zero
        View.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
        View.layer.cornerRadius = ControlX(10)
        return View
    }()
    
    lazy var ImageRating : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleToFill
        ImageView.layer.cornerRadius = ControlX(10)
        return ImageView
    }()
    
    lazy var LabelTitel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Label
    }()
    
    lazy var LabelDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        Label.numberOfLines = 3
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "SourceSansPro-Regular" ,size: ControlWidth(16))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        return Label
    }()
    
    lazy var DateLabel : ImageAndLabel = {
        let View = ImageAndLabel()
        View.Label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.IconImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.IconImage.setImage(UIImage(named: "calendar"), for: .normal)
        View.IconSize = CGSize(width: ControlHeight(14), height: ControlHeight(14))
        View.Label.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(14))
        View.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return View
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [LabelTitel,LabelDetails,DateLabel])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(5)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()

    lazy var RatingLabel1 : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "How was your experience?".localizable
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()

    lazy var YourExperience : CosmosView = {
        let view = CosmosView()
        view.settings.filledImage = #imageLiteral(resourceName: "RatingSelected").withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = #imageLiteral(resourceName: "Rating").withRenderingMode(.alwaysOriginal)
        view.settings.fillMode = .full
        view.settings.textMargin = 10
        view.settings.starSize = 15
        view.settings.starSize = ControlWidth(26)
        return view
    }()
    
    lazy var RatingLabel2 : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "How was the event organization?".localizable
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()

    lazy var Organization : CosmosView = {
        let view = CosmosView()
        view.settings.filledImage = #imageLiteral(resourceName: "RatingSelected").withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = #imageLiteral(resourceName: "Rating").withRenderingMode(.alwaysOriginal)
        view.settings.fillMode = .full
        view.settings.textMargin = 10
        view.settings.starSize = 15
        view.settings.starSize = ControlWidth(26)
        return view
    }()
    
    lazy var RatingLabel3 : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Overall Rating".localizable
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()

    lazy var Rat : CosmosView = {
        let view = CosmosView()
        view.settings.filledImage = #imageLiteral(resourceName: "RatingSelected").withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = #imageLiteral(resourceName: "Rating").withRenderingMode(.alwaysOriginal)
        view.settings.fillMode = .full
        view.settings.textMargin = 10
        view.settings.starSize = 15
        view.settings.starSize = ControlWidth(26)
        return view
    }()
    
    lazy var AddReviewLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.backgroundColor = .clear
        Label.text = "Add your review".localizable
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var StackRating : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [RatingLabel1,YourExperience,RatingLabel2,Organization,RatingLabel3,Rat,AddReviewLabel])
        Stack.axis = .vertical
        Stack.spacing = ControlWidth(15)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()

    lazy var TextView : GrowingTextView = {
    let TV = GrowingTextView()
    TV.placeholder = "Review".localizable
    TV.minHeight = ControlWidth(40)
    TV.maxHeight = ControlWidth(150)
    TV.placeholderColor = #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)
    TV.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    TV.textColor = .black
    TV.clipsToBounds = true
    TV.backgroundColor = .clear
    TV.autocorrectionType = .no
    TV.translatesAutoresizingMaskIntoConstraints = false
    TV.font = UIFont(name: "SourceSansPro-Regular", size: ControlWidth(15))
    return TV
    }()
    
    lazy var ViewLine:UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    lazy var AddReview : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Add Review".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionReview), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Black", size: ControlWidth(16))
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionReview() {
    if canEdit == true {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    guard let placesId = PlacesId else{return}
    let api = "\(url + AddReviews)"

    let sqlId = getProfileObject().sqlId ?? ""
    let token = defaults.string(forKey: "jwt") ?? ""
    let yourExperience = Int(YourExperience.rating)
    let organization = Int(Organization.rating)
    let rate = Int(Rat.rating)
    let comment = TextView.text ?? ""
        
    let parameters:[String:Any] = ["AppId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
                                    "Platform": "I",
                                    "sqlId": sqlId,
                                    "placesId": placesId,
                                    "yourExperience": yourExperience,
                                    "organization": organization,
                                    "rate": rate,
                                    "comment": comment]
        
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.ViewDots.endRefreshing("Success Add Review".localizable, .success) {}
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { Error in
    self.ViewDots.endRefreshing(Error, .error) {}
    }
    }else{
    ShowMessageAlert("Error", "Error".localizable, "You can't Edit the is Review".localizable, true, {})
    }
    }
    
}
