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
    
    func mapping() -> BookEntity {
        
    }
}
