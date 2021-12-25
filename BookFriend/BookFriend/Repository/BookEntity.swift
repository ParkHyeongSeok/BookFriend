//
//  BookEntity.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/25.
//

import Foundation

class BookEntity: Codable {
    var title: String
    var link: URL?
    var image: URL?
    var author: String?
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case title, link, image, author, description
    }
}

extension BookEntity: Equatable {
    static func == (rhs: BookEntity, lhs: BookEntity) -> Bool {
        return rhs.title == lhs.title
    }
}

extension BookEntity: EntityConvertible {
    typealias MODEL = Book
    func convert() -> Book? {
        let book = Book()
        book.mapping(to: self)
        return book
    }
}
