//
//  BookRealmDTO.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/26.
//

import Foundation
import RealmSwift

class BookRealmDTO: Object {
    @Persisted var title: String = ""
    @Persisted var link: String? = nil
    @Persisted var image: String? = nil
    @Persisted var author: String? = nil
    @Persisted var descriptions: String = ""
}

extension BookRealmDTO: PersistentEntity {
    func mapping(to model: Book) {
        self.title = model.title
        self.link = model.link?.absoluteString
        self.image = model.image?.absoluteString
        self.author = model.author
        self.descriptions = model.description
    }
    
    func getModel() -> Book {
        return Book.init(title: title, link: URL(string: link ?? ""), image: URL(string: image ?? ""), author: author, description: descriptions)
    }
}

extension BookRealmDTO: DomainModelMapper {
    func convert() -> Book {
        let book = Book()
        book.mapping(to: self)
        return book
    }
}
