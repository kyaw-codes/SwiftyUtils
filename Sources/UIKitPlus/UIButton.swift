//
//  UIButton.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import UIKit

public extension UIButton {
    
    func highlightPartOf(_ text:String, normalColor:UIColor, normalFont: UIFont, highlightText:[String], highlightColor:UIColor, highlightFont: UIFont, lineSpacing:CGFloat = 1) {
        let nsString = text as NSString
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineSpacing
        
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
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
