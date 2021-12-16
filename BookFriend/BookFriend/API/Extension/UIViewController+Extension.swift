//
//  UIViewController+Extension.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/15.
//

import UIKit

extension BookListViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let identifier = fullName.components(separatedBy: ".")[1]
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
