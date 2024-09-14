//
//  NSAttributedString.swift
//  SwiftyUtils
//
//  Created by Kyaw Zay Ya Lin Tun on 14/09/2024.
//

import UIKit

// MARK: Need documentation and UTs
extension String {
    // https://stackoverflow.com/a/34423577/3378606
    func height(for width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        return actualSize.height
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.foregroundColor : color])
    }
    
    func background(_ color: UIColor) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.backgroundColor: color])
    }
    
    func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.underlineColor: color, .underlineStyle: style.rawValue])
    }
    
    func font(_ font: UIFont) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.font: font])
    }
    
    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.shadow: shadow])
    }
    
    var attributed: NSAttributedString {
        NSAttributedString(string: self)
    }
}

extension NSAttributedString {
    func apply(_ attributes: [NSAttributedString.Key:Any]) -> NSAttributedString {
        let mutable = NSMutableAttributedString(
            string: self.string,
            attributes: self.attributes(at: 0, effectiveRange: nil)
        )
        mutable.addAttributes(attributes, range: NSMakeRange(0, (self.string as NSString).length))
        return mutable
    }
    
    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        self.apply([.foregroundColor : color])
    }
    
    func background(_ color: UIColor) -> NSAttributedString {
        self.apply([.backgroundColor: color])
    }
    
    func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> NSAttributedString {
        self.apply([.underlineColor: color, .underlineStyle: style.rawValue])
    }
    
    func font(_ font: UIFont) -> NSAttributedString {
        self.apply([.font: font])
    }
    
    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        self.apply([.shadow:shadow])
    }
}
