//
//  String+Extension.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/07.
//

import UIKit

extension String {
    func htmlEscaped(font: UIFont) -> NSAttributedString {
        let style = """
                    <style>
                    p.normal {
                      font-size: \(font.pointSize)px;
                      font-family: \(font.familyName);
                    }
                    </style>
        """
        let modified = String(format:"\(style)<p class=normal>%@</p>", self)
        do {
            guard let data = modified.data(using: .unicode) else {
                return NSAttributedString(string: self)
            }
            let attributed = try NSAttributedString(data: data,
                                                    options: [.documentType: NSAttributedString.DocumentType.html],
                                                    documentAttributes: nil)
            return attributed
        } catch {
            return NSAttributedString(string: self)
        }
    }
}
