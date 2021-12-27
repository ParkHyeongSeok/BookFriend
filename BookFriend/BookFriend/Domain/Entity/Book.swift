//
//  BookEntity.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

class Book: Identifiable {
    typealias Identifier = String
    enum Genre {
        case novel, poet, essay
    }
    let title: Identifier
    let genre: Genre
    let link: URL?
    let image: URL?
    let author: String?
    let description: String
    
    init(
        title: String,
        genre: Genre,
        link: URL?,
        image: URL?,
        author: String?,
        description: String
    ) {
        self.title = title
        self.genre = genre
        self.link = link
        self.image = image
        self.author = author
        self.description = description
    }
}

extension Book: Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title
    }
}
