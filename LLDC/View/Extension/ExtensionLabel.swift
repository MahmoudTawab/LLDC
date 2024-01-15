//
//  ExtensionLabel.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit


extension UILabel {
    func addInterlineSpacing(spacingValue: CGFloat = 2) {
    guard let textString = text else { return }
    let attributedString = NSMutableAttributedString(string: textString)

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = spacingValue
        
    attributedString.addAttribute(
    .paragraphStyle,
    value: paragraphStyle,
    range: NSRange(location: 0, length: attributedString.length
    ))
    attributedText = attributedString
    }
    
    func didTapAttributedTextInLabel(gesture: UITapGestureRecognizer, inRange targetRange: NSRange) -> Bool {

            let layoutManager = NSLayoutManager()
            let textContainer = NSTextContainer(size: CGSize.zero)
            guard let strAttributedText = self.attributedText else {
                return false
            }

            let textStorage = NSTextStorage(attributedString: strAttributedText)

            // Configure layoutManager and textStorage
            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)

            // Configure textContainer
            textContainer.lineFragmentPadding = 0.0
            textContainer.lineBreakMode = self.lineBreakMode
            textContainer.maximumNumberOfLines = self.numberOfLines
            let labelSize = self.bounds.size
            textContainer.size = CGSize(width: labelSize.width, height: CGFloat.greatestFiniteMagnitude)

            // Find the tapped character location and compare it to the specified range
            let locationOfTouchInLabel = gesture.location(in: self)

            let xCordLocationOfTouchInTextContainer = locationOfTouchInLabel.x
            let yCordLocationOfTouchInTextContainer = locationOfTouchInLabel.y
            let locOfTouch = CGPoint(x: xCordLocationOfTouchInTextContainer ,
                                     y: yCordLocationOfTouchInTextContainer)

            let indexOfCharacter = layoutManager.characterIndex(for: locOfTouch, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

            guard let strLabel = text else {
                return false
            }

            let charCountOfLabel = strLabel.count

            if indexOfCharacter < (charCountOfLabel - 1) {
                return NSLocationInRange(indexOfCharacter, targetRange)
            } else {
                return false
            }
        }
    
    func decideTextDirection() {
    let tagScheme = [NSLinguisticTagScheme.language]
    let tagger    = NSLinguisticTagger(tagSchemes: tagScheme, options: 0)
    tagger.string = self.text
    let lang      = tagger.tag(at: 0, scheme: NSLinguisticTagScheme.language,
                                              tokenRange: nil, sentenceRange: nil)

    if lang?.rawValue.range(of:"ar") != nil {
    self.textAlignment = NSTextAlignment.right
    } else {
    self.textAlignment = NSTextAlignment.left
    }
    }
    
    func MutableStrikethrough(_ Color:UIColor,_ Font:UIFont) {
    guard let Text = self.text else {return}
    let attributedString = NSMutableAttributedString(string: Text)
        
    let style = NSMutableParagraphStyle()
    style.alignment = .right
        
    let secondAttributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: Color,
    .backgroundColor: UIColor.clear,
    .font : Font ,
    .paragraphStyle:style,
    .strikethroughStyle: 1]
        
    attributedString.addAttributes(secondAttributes, range: NSRange(location: 0, length: Text.count))
    self.attributedText = attributedString
    }
}
