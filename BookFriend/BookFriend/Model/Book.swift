//
//  Book.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

struct Book: Codable {
    typealias MODEL = Book

    let title: String
    let link: URL?
    let image: URL?
    let author: String?
    let description: String
    
    func mapping(to model: Book) {
        <#code#>
    }
}

extension Book: Equatable {
    static func == (rhs: Book, lhs: Book) -> Bool {
        return rhs.title == lhs.title
    }
}

extension Book: 
