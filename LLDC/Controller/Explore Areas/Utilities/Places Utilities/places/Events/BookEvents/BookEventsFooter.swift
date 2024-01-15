//
//  BookEventsFooter.swift
//  LLDC
//
//  Created by Emojiios on 26/06/2022.
//

import UIKit

protocol BookFooterEventsDelegate {
    func ActionBook(_ Cell:BookEventsFooter)
}

class BookEventsFooter: UIView {
    
    var Delegate:BookFooterEventsDelegate?
    lazy var NotesTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.attributedPlaceholder = NSAttributedString(string: "Notes (Optional)".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var CardDetails : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.cornerRadius = ControlX(10)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var TotalStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TotalLabel,BookTable])
        Stack.axis = .horizontal
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
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
    Delegate?.ActionBook(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(NotesTF)
        NotesTF.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        NotesTF.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(40)).isActive = true
        NotesTF.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        NotesTF.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        addSubview(CardDetails)
        CardDetails.topAnchor.constraint(equalTo: NotesTF.bottomAnchor, constant: ControlY(20)).isActive = true
        CardDetails.heightAnchor.constraint(equalToConstant: ControlWidth(75)).isActive = true
        CardDetails.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        CardDetails.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        CardDetails.addSubview(TotalStack)
        TotalStack.topAnchor.constraint(equalTo: CardDetails.topAnchor, constant: ControlY(12)).isActive = true
        TotalStack.bottomAnchor.constraint(equalTo: CardDetails.bottomAnchor, constant: ControlX(-12)).isActive = true
        TotalStack.leadingAnchor.constraint(equalTo: CardDetails.leadingAnchor, constant: ControlX(15)).isActive = true
        TotalStack.trailingAnchor.constraint(equalTo: CardDetails.trailingAnchor, constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
