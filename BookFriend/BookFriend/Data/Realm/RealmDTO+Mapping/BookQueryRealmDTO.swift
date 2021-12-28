//
//  BookQueryRealmDTO.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/28.
//

import Foundation
import RealmSwift

class BookQueryRealmDTO: Object {
    @Persisted var query: String
    
    convenience init(
        query: String
    ) {
        self.init()
        self.query = query
    }
}

extension BookQueryRealmDTO {
    func toDomain() -> BookQuery {
        return .init(query: query)
    }
}
