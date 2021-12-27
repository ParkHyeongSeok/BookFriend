//
//  BookNetworkDTO.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/27.
//

import Foundation

struct NetworkResponseDTO<Wrapper: Codable>: Codable {
    var items: [Wrapper]
}

struct BookNetworkDTO: Codable {
    var title: String
    var link: URL?
    var image: URL?
    var author: String?
    var description: String
}

extension BookNetworkDTO {
    
    private func checkGenre(_ title: String) -> Book.Genre {
        if title.hasPrefix("novel") {
            return .novel
        } else if title.hasPrefix("poem") {
            return .poem
        } else if title.hasPrefix("essay") {
            return .essay
        } else {
            return .none
        }
    }
    
    func toDomain() -> Book {
        let genre = self.checkGenre(title)
        return .init(title: title, genre: genre, link: link, image: image, author: author ?? "nobody", description: description)
    }
}
