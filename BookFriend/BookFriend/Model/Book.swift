//
//  Book.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

class Book: NetworkModel {
    typealias ENTITY = BookEntity
    
    private(set) var title: String = ""
    private(set) var link: URL? = nil
    private(set) var image: URL? = nil
    private(set) var author: String? = nil
    private(set) var description: String = ""
    
    func mapping(to entity: BookEntity) {
        self.title = entity.title
        self.link = entity.link
        self.image = entity.image
        self.author = entity.author
        self.description = entity.description
    }
}

extension Book: Equatable {
    static func == (rhs: Book, lhs: Book) -> Bool {
        return rhs.title == lhs.title
    }
}
