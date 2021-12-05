//
//  Book.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

struct Book: Codable {
    let title: String
    let link: URL
    let image: URL?
    let author: String?
    let description: String
}
