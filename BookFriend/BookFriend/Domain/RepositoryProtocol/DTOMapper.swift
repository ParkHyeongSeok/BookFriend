//
//  DTOMapper.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/28.
//

import Foundation

protocol DTOMapper {

}

extension DTOMapper where Self: BookRepository {
    func mapping(_ entity: Book) -> BookRealmDTO {
        return .init(title: entity.title, genre: entity.genre.rawValue, link: entity.link?.absoluteString, image: entity.image?.absoluteString, author: entity.author, descriptions: entity.description)
    }
}

extension DTOMapper where Self: BookQueryRepository {
    func mapping(_ entity: BookQuery) -> BookQueryRealmDTO {
        return .init(query: entity.query)
    }
}
