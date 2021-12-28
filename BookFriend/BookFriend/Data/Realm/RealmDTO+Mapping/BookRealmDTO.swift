//
//  BookRealmDTO.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/26.
//

import Foundation
import RealmSwift

class BookRealmDTO: Object {
    @Persisted var title: String
    @Persisted var genre: String
    @Persisted var link: String
    @Persisted var image: String
    @Persisted var author: String
    @Persisted var descriptions: String
    
    convenience init(
        title: String,
        genre: String,
        link: String?,
        image: String?,
        author: String,
        descriptions: String
    ) {
        self.init()
        self.title = title
        self.genre = genre
        self.link = link ?? ""
        self.image = image ?? ""
        self.author = author
        self.descriptions = descriptions
    }
}

extension BookRealmDTO {
    func toDomain() -> Book {
        return .init(title: title, genre: Book.Genre(rawValue: genre), link: URL(string: link), image: URL(string: image), author: author, description: descriptions)
    }
}
