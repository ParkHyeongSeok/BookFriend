//
//  Book.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

class Book: DomainModel {
    typealias NETWORKENTITY = BookEntity
    typealias REALMENTITY = BookRealmEntity
    
    private(set) var title: String = ""
    private(set) var link: URL? = nil
    private(set) var image: URL? = nil
    private(set) var author: String? = nil
    private(set) var description: String = ""
    
    /// Mapping for Networking Entity
    func mapping(to entity: BookEntity) {
        self.title = entity.title
        self.link = entity.link
        self.image = entity.image
        self.author = entity.author
        self.description = entity.description
    }
    
    /// Mapping for Realm Entity
    func mapping(to entity: BookRealmEntity) {
        self.title = entity.title
        self.link = URL(string: entity.link ?? "")
        self.image = URL(string: entity.image ?? "")
        self.author = entity.author
        self.description = entity.description
    }
}

extension Book: Equatable {
    static func == (rhs: Book, lhs: Book) -> Bool {
        return rhs.title == lhs.title
    }
}

extension Book: PersistentEntityMapper {
    typealias ENTITY = REALMENTITY
    func convert() -> ENTITY {
        let mapper = BookRealmEntity()
        mapper.mapping(to: self)
        return mapper
    }
}
