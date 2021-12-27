//
//  BookRealmDTO.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/26.
//

import Foundation
import RealmSwift

protocol BookRealmDTOMapper {
    associatedtype ENTITY
    associatedtype DTO
    func mapping(_ entity: ENTITY) -> DTO
}

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

extension BookRealmDTO: BookRealmDTOMapper {
    typealias ENTITY = Book
    typealias DTO = BookRealmDTO
    func mapping(_ entity: Book) -> BookRealmDTO {
        return .init(title: entity.title, genre: entity.genre.rawValue, link: entity.link?.absoluteString, image: entity.image?.absoluteString, author: entity.author, descriptions: entity.description)
    }
}

extension BookRealmDTO {
    func toDomain() -> Book {
        return .init(title: title, genre: Book.Genre(rawValue: genre), link: URL(string: link), image: URL(string: image), author: author, description: descriptions)
    }
}
