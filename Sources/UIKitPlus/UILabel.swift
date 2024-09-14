//
//  UILabel.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//


import UIKit

public extension UILabel {
    
    convenience init(font: UIFont, color: UIColor, numberOfLines: Int = 0, textAlignment: NSTextAlignment = .center) {
        self.init(frame: .zero)
        self.font = font
        self.textColor = color
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
    }
    
    var visibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
        
        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                }
            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return self.text!.count
    }
    
    var lines: Int {
        self.layoutIfNeeded()
        let textSize = CGSize(width: self.frame.size.width, height: CGFloat(Float.infinity))
        let rHeight = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize = lroundf(Float(self.font.lineHeight))
        let lineCount = rHeight/charSize
        return lineCount
    }
    
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText
        
        let lengthForVisibleString: Int = self.visibleTextLength
        let mutableString: String = self.text!
        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font!])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }
    
    func changeTextWithAni(_ text: String?, option: UIView.AnimationOptions = .transitionCrossDissolve) {
        UIView.transition(with: self, duration: 0.2, options: option, animations: {
            self.text = text
        }, completion: nil)
    }
    
    func highlightPartOf(_ text:String, normalColor:UIColor, normalFont: UIFont, highlightText:[String], highlightColor:UIColor, highlightFont: UIFont, lineSpacing:CGFloat = 1) {
        
        self.numberOfLines = 0
        
        let nsString = text as NSString
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineSpacing
        paragraphStyle.alignment = self.textAlignment
        
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .paragraphStyle: paragraphStyle,
            .font: normalFont,
            .foregroundColor: normalColor
        ])
        
        var highlightRanges: [NSRange] = []
        for highlight in highlightText {
            let range = nsString.range(of: highlight)
            attributedString.addAttributes([
                .foregroundColor: highlightColor,
                .font: highlightFont,
            ], range: range)
            highlightRanges.append(range)
        }
        self.attributedText = attributedString;
    }
    
    func addBulletString(
        _ stringList: [String],
        font: UIFont,
        bullet: String = "•",
        indentation: CGFloat = 10,
        lineSpacing: CGFloat = 1,
        paragraphSpacing: CGFloat = 12,
        textColor: UIColor = .black,
        bulletColor: UIColor = .black
    ) {
        
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
        let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: bulletColor]
        
        let paragraphStyle = NSMutableParagraphStyle()
        let nonOptions = [NSTextTab.OptionKey: Any]()
        paragraphStyle.tabStops = [
            NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
        paragraphStyle.defaultTabInterval = indentation
        //paragraphStyle.firstLineHeadIndent = 0
        //paragraphStyle.headIndent = 20
        //paragraphStyle.tailIndent = 1
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.headIndent = indentation
        
        let bulletList = NSMutableAttributedString()
        for i in 0..<stringList.count {
            var formattedString = "\(bullet)\t\(stringList[i])"
            if i < stringList.count - 1 { formattedString.append("\n") }
            let attributedString = NSMutableAttributedString(string: formattedString)
            
            attributedString.addAttributes(
                [NSAttributedString.Key.paragraphStyle : paragraphStyle],
                range: NSMakeRange(0, attributedString.length))
            
            attributedString.addAttributes(
                textAttributes,
                range: NSMakeRange(0, attributedString.length))
            
            let string:NSString = NSString(string: formattedString)
            let rangeForBullet:NSRange = string.range(of: bullet)
            attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
            bulletList.append(attributedString)
        }
        
        self.attributedText = bulletList
    }
    
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font ?? UIFont()], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
    
    func setSpacing(letterSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = letterSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = self.textAlignment
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    func setBulletText(strings: [String],
                       bullet: String = "•   ",
                       separator: String = "\n\n",
                       endingSeparator: String = "",
                       textColor: UIColor? = nil) {
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
        attributes[.foregroundColor] = textColor.orElse(self.textColor)
        attributes[.font] = font
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle
        
        let string = strings.map { return bullet + $0 }.joined(separator: separator)
        self.attributedText = NSAttributedString(string: string + endingSeparator, attributes: attributes)
    }
    
    func customSize(size: Int){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = CGFloat(size)
        paragraphStyle.maximumLineHeight = CGFloat(size)
        self.attributedText = NSAttributedString(
            string: self.text ?? "",
            attributes: [
                .paragraphStyle : paragraphStyle
            ]
        )
        
    }
}
