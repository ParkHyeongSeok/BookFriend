//
//  BookRealmEntity.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/26.
//

import Foundation
import RealmSwift

class BookRealmEntity: Object {
    typealias MODEL = Book
    @Persisted var title: String = ""
    @Persisted var link: String? = nil
    @Persisted var image: String? = nil
    @Persisted var author: String? = nil
    @Persisted var descriptions: String = ""
}

extension BookRealmEntity: PersistentEntity {
    func mapping(to model: Book) {
        self.title = model.title
        self.link = model.link?.absoluteString
        self.image = model.image?.absoluteString
        self.author = model.author
        self.descriptions = model.description
    }
}

extension BookRealmEntity: DomainModelMapper {
    func convert() -> Book {
        let book = Book()
        book.mapping(to: self)
        return book
    }
}
