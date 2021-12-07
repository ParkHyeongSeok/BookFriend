//
//  RealmRepositoryType.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/06.
//

import Foundation

protocol RealmRepositoryType {
    typealias RealmResult = (Result<RealmSuccess, RealmError>) -> Void
    func create(completion: @escaping RealmResult)
    func read(completion: @escaping RealmResult)
    func update(bookID: String, completion: @escaping RealmResult)
    func delete(bookID: String, completion: @escaping RealmResult)
}
