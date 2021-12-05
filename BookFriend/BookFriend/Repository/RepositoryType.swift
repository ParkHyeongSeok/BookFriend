//
//  RepositoryType.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

protocol RepositoryType {
    typealias RealmResult = (Result<RealmSuccess, RealmFailure>) -> Void
    func create(completion: @escaping RealmResult)
    func read(completion: @escaping RealmResult)
    func delete(with bookID: String, completion: @escaping RealmResult)
    func update(to bookID: String, completion: @escaping RealmResult)
}
