//
//  BookEntity.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/25.
//

import Foundation

class BookEntity: Codable, NetworkEntity {
    typealias MODEL = Book
    
    private(set) var title: String
    private(set) var link: URL?
    private(set) var image: URL?
    private(set) var author: String?
    private(set) var description: String
    
    func mapping(to model: MODEL) {
        self.title = model.title
        self.link = model.link
        self.image = model.image
        self.author = model.author
        self.description = model.description
    }
}

extension BookEntity: Equatable {
    static func == (rhs: BookEntity, lhs: BookEntity) -> Bool {
        return rhs.title == lhs.title
    }
}
