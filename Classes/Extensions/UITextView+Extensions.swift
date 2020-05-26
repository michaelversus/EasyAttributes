//
//  UITextView+Extensions.swift
//  EasyAttributes
//
//  Created by Karagiorgos, Michalis, Vodafone Greece on 26/05/2020.
//

import UIKit

extension UITextView {
    public convenience init(easyAttributesString: String,
                     font: UIFont,
                     textColor: UIColor,
                     backgroundColor: UIColor,
                     textAlignment: NSTextAlignment,
                     linkColor: UIColor,
                     isEditable: Bool = false,
                     isScrollEnabled: Bool = false,
                     isSelectable: Bool = true,
                     textContainerInset: UIEdgeInsets = .zero,
                     lineFragmentPadding: CGFloat = 0
    ) {
        self.init()
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = textAlignment
        let mainAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .paragraphStyle: paragraph
        ]
        let linkTextAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: linkColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: linkColor
        ]
        self.linkTextAttributes = linkTextAttributes
        self.attributedText = easyAttributesString.toAttributed(with: mainAttributes)
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
        self.isEditable = isEditable
        self.isScrollEnabled = isScrollEnabled
        self.isSelectable = isSelectable
        self.isUserInteractionEnabled = true
        self.textContainerInset = textContainerInset
        self.textContainer.lineFragmentPadding = lineFragmentPadding
        self.sizeToFit()
    }
}
