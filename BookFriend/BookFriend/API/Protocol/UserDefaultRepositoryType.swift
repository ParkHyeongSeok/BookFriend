//
//  UserDefaultRepositoryType.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/06.
//

import Foundation

protocol UserDefaultRepositoryType {
    typealias UserDefaultResult = (Result<UserDefaultSuccess, UserDefaultError>) -> Void
    func create(query: String, completion: @escaping UserDefaultResult)
    func read(completion: @escaping UserDefaultResult)
    func delete(query: String, completion: @escaping UserDefaultResult)
}
