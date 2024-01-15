//
//  BookFooter.swift
//  LLDC
//
//  Created by Emojiios on 19/06/2022.
//

import UIKit

protocol BookFooterDelegate {
    func ActionBook(Cell:BookFooter)
}

class BookFooter: UICollectionViewCell {
    
    var Book:BookVC?
    var Delegate:BookFooterDelegate?
    lazy var ViewBackground:UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.cornerRadius = ControlX(8)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var Stack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [DateTF,TimeTF,NotesTF,TotalStack])
        Stack.axis = .vertical
        Stack.spacing = ControlHeight(18)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .white
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    var DateTime : DateOrTime?
    lazy var DateTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = .clear
        tf.ShowError = false
        tf.Icon.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.IconImage = UIImage(named: "calendar-2")
        tf.SetUpIcon(LeftOrRight: false, Width: 28, Height: 28)
        tf.addTarget(self, action: #selector(ActionDate), for: .editingDidBegin)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionDate), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionDate)))
        tf.attributedPlaceholder = NSAttributedString(string: "Date".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionDate() {
        DateTime = .Date
        ActionDateAndTime()
    }
    
    lazy var TimeTF : FloatingTF = {
        let tf = FloatingTF()
        let view = UIView()
        view.backgroundColor = .clear
        tf.inputView = view
        tf.Enum = .ReadOnly
        tf.tintColor = .clear
        tf.ShowError = false
        tf.Icon.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tf.IconImage = UIImage(named: "clock")
        tf.SetUpIcon(LeftOrRight: false, Width: 25, Height: 28)
        tf.addTarget(self, action: #selector(ActionTime), for: .editingDidBegin)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.Icon.addTarget(self, action: #selector(ActionTime), for: .touchUpInside)
        tf.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(ActionTime)))
        tf.attributedPlaceholder = NSAttributedString(string: "Time".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    @objc func ActionTime() {
        DateTime = .Time
        ActionDateAndTime()
    }
    
    let DatePicker = UIDatePicker()
    @objc func ActionDateAndTime() {
        
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
        
        Label.text = DateTime == .Date ? "Date".localizable:"Time".localizable
        Label.font = UIFont(name: "SourceSansPro-Bold" ,size: ControlWidth(20))
        PopUp.View.addSubview(Label)
        Label.frame = CGRect(x: ControlX(20), y: ControlY(15), width: PopUp.view.frame.width - ControlX(40), height: ControlWidth(30))
            
        DatePicker.minimumDate = Date()
        DatePicker.backgroundColor = .white
        DatePicker.locale = Locale(identifier: "lang".localizable)
        DatePicker.datePickerMode = DateTime == .Date ? .date:.time
        creatTimePicker(Book?.openingHoursFrom ?? "" ,Book?.openingHoursTo ?? "")
        if #available(iOS 13.4, *) {DatePicker.preferredDatePickerStyle = .wheels} else {}
        
        DatePicker.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        DatePicker.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        DatePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        PopUp.View.addSubview(DatePicker)
        DatePicker.frame = CGRect(x: ControlX(20), y: Label.frame.maxY + ControlY(5), width: PopUp.view.frame.width - ControlX(40), height: ControlWidth(180))
        Book?.present(PopUp, animated: true)
    }
    
    @objc func datePickerValueChanged() {
    if DateTime == .Date {
    DateTF.text = DatePicker.date.Formatter("dd/MM/yyyy")
    }else{
    TimeTF.text = DatePicker.date.Formatter("hh/mm a")
    }
    }
    
    func creatTimePicker(_ min:String,_ max:String) {
    if DatePicker.datePickerMode == .time {
    let timeformatter = DateFormatter()
    timeformatter.dateFormat = "h:ma"
    timeformatter.locale = Locale(identifier: "lang".localizable)

    let min = timeformatter.date(from: min)
    let max = timeformatter.date(from: max)
    DatePicker.minimumDate = min
    DatePicker.maximumDate = max
    }
    }

    lazy var NotesTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(45)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Notes (Optional)".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var CardDetails : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.cornerRadius = ControlX(10)
        return View
    }()
    
    lazy var TotalStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TotalLabel,BookTable])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        return Stack
    }()
    
    lazy var TotalLabel : UILabel = {
        let Label = UILabel()
        return Label
    }()
    
    func SetTotal(Total:String) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(10)
        
        let attributedString = NSMutableAttributedString(string: "Total".localizable, attributes: [
            .font: UIFont(name: "SourceSansPro-Black", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: Total, attributes: [
            .font: UIFont(name: "SourceSansPro-Regular", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        TotalLabel.backgroundColor = .clear
        TotalLabel.attributedText = attributedString
    }
    
    lazy var BookTable : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.3735483289, green: 0.4846487045, blue: 0.5549171567, alpha: 1)
        Button.clipsToBounds = true
        Button.setTitle("Book Table".localizable, for: .normal)
        Button.titleLabel?.font = UIFont(name: "SourceSansPro-Bold", size: ControlWidth(16))
        Button.addTarget(self, action: #selector(ActionBookTable), for: .touchUpInside)
        Button.setTitleColor(#colorLiteral(red: 0.9484218955, green: 0.9487742782, blue: 0.9211550355, alpha: 1), for: .normal)
        return Button
    }()

    @objc func ActionBookTable() {
    Delegate?.ActionBook(Cell: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(ViewBackground)
        ViewBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(10)).isActive = true
        ViewBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-10)).isActive = true
        ViewBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ViewBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        ViewBackground.addSubview(Stack)
        Stack.topAnchor.constraint(equalTo: ViewBackground.topAnchor, constant: ControlY(10)).isActive = true
        Stack.bottomAnchor.constraint(equalTo: ViewBackground.bottomAnchor, constant: ControlX(-10)).isActive = true
        Stack.leadingAnchor.constraint(equalTo: ViewBackground.leadingAnchor, constant: ControlX(15)).isActive = true
        Stack.trailingAnchor.constraint(equalTo: ViewBackground.trailingAnchor, constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
