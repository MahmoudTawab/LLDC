//
//  ReviewsVC.swift
//  LLDC
//
//  Created by Emojiios on 16/06/2022.
//

import UIKit
import SDWebImage

class ReviewsVC: ViewController , UITableViewDelegate, UITableViewDataSource {

    var PlacesId:String?
    var Reviews = [PlaceReviews]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        GetAllReviews()
        view.backgroundColor = #colorLiteral(red: 0.9059781432, green: 0.9064524174, blue: 0.8731874824, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        view.addSubview(Dismiss)
        Dismiss.Label.textColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Dismiss.TextLabel = "Reviews".localizable
        Dismiss.frame = CGRect(x: ControlX(10), y: ControlY(40), width: view.frame.width - ControlX(20), height: ControlWidth(40))
        
        view.addSubview(ReviewsTable)
        ReviewsTable.topAnchor.constraint(equalTo: Dismiss.bottomAnchor, constant: ControlY(10)).isActive = true
        ReviewsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        ReviewsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        ReviewsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    let ReviewsId = "ReviewsId"
    lazy var ReviewsTable : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.delegate = self
        tv.dataSource = self
        tv.isHidden = true
        tv.backgroundColor = .clear
        tv.separatorColor = .clear
    
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        tv.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tv.addPullLoadableView(loadMoreView, type: .loadMore)
        
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ReviewsCell.self, forCellReuseIdentifier: ReviewsId)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(20), right: 0)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsId, for: indexPath) as! ReviewsCell
    cell.backgroundColor = .clear
    cell.selectionStyle = .none
    let data = Reviews[indexPath.row]
    cell.NameLabel.text = data.FullName ?? ""
    cell.CommentLabel.text = data.Comment ?? ""
    cell.ViewRating.rating = Double(data.Rate ?? 1)
    cell.DateLabel.TextLabel = data.CreatedIn?.Formatter().Formatter("dd MMM yyyy") ?? ""
    cell.ProfileImage.sd_setImage(with: URL(string: data.ProfileImg ?? ""), placeholderImage: UIImage(named: "Profile"))
    cell.addBottomLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), height: ControlWidth(1.5), space: 0)
    return cell
    }
    
    
    var skip = 0
    var Animations = true
    var fetchingMore = false
    @objc func GetAllReviews(removeAll:Bool = false, ShowDots:Bool = true) {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    guard let PlacesId = PlacesId else{return}
//
//    let api = "\(url + GetPlaceReviews)"
//    let sqlId = getProfileObject().sqlId ?? ""
//    let token = defaults.string(forKey: "jwt") ?? ""
//
//    let parameters:[String:Any] = ["appId": "ee56d822-c63b-427e-8018-2fd374ec1cca",
//                                   "platform": "I",
//                                   "Lang": "lang".localizable,
//                                   "sqlId": sqlId,
//                                   "PlacesId": PlacesId,
//                                   "Take": 10,
//                                   "Skip": skip]
        
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [["Rate":3,"ProfileImg":"https://64.media.tumblr.com/c4112fdd75264cfd130e18c5b61372bc/2106ba7702407cd2-f9/s250x400/d05f044d56f0b289a3ad68af36fc6ab2c6e05e4b.jpg","FullName":"Mahmoud","Comment":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France,","CreatedIn":"23/10"],
                          ["Rate":4,"ProfileImg":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVwF2_Tq-oof1kYOx0vLV2cDbsb91nK0CHSHygtzy7hvmtSdk3dV-OJ48XPKsiS3gQhUg&usqp=CAU","FullName":"Tawab","Comment":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France,","CreatedIn":"23/10"],
                          ["Rate":2,"ProfileImg":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjo9tBxLMbtiyaxL6xuzxpTchjsnTOT6E5y9hidbszvM5EFScixl2SC0V0BZ85irBehZw&usqp=CAU","FullName":"Hosny","Comment":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France,","CreatedIn":"23/10"],
                          ["Rate":5,"ProfileImg":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRi3bH95z3j_zedLraRVdBhWNvlPKGfGjiphMQXNwwzUr5XamQWZo--ieivhs7X3szPTuo&usqp=CAU","FullName":"Ali","Comment":"restaurant, establishment where refreshments or meals may be procured by the public. The public dining room that ultimately came to be known as the restaurant originated in France,","CreatedIn":"23/10"]]
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            if removeAll {
                self.ReviewsTable.RemoveAnimations {
                    self.Reviews.removeAll()
                    self.Animations = true
                    self.AddData(dictionary:data)
                }
            }else{
                self.AddData(dictionary:data)
            }
            
        }
//    } Err: { error in
//    if self.Reviews.count != 0 {
//    return
//    }else{
//    self.IfNoData()
//    self.SetUpIsError(error,true) {self.refresh()}
//    }
//    }
    }
    

    func AddData(dictionary:[[String:Any]]) {
    for item in dictionary {
    self.Reviews.append(PlaceReviews(dictionary: item))
    self.skip += 1
    self.fetchingMore = false
    self.Animations == true ? self.ReviewsTable.SetAnimations() {self.Animations = false} : self.ReviewsTable.reloadData()
    }
    self.IfNoData()
    }
    
    
    @objc func refresh() {
    skip = 0
    GetAllReviews(removeAll: true)
    }
    
    func IfNoData() {
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    self.ViewNoData.isHidden = self.Reviews.count != 0 ? true : false
    self.ReviewsTable.isHidden = self.Reviews.count == 0 ? true : false
    self.ViewDots.endRefreshing(){}
    }
}


extension ReviewsVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.GetAllReviews(removeAll: false, ShowDots: false)
        }
        default: break
        }
        return
        }

        switch state {
        case .none:
        pullLoadView.messageLabel.text = ""
        case .pulling(_, _):
        pullLoadView.messageLabel.text = "Pull more".localizable
        case let .loading(completionHandler):
        pullLoadView.messageLabel.text = "Updating".localizable
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.refresh()
        }
        }
        return
        }
}
