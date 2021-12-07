//
//  RealmRepository.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

class RealmRepository: RealmRepositoryType {
    
    func create(completion: @escaping RealmResult) {
        completion(.success(.data))
    }
    
    func read(completion: @escaping RealmResult) {
        completion(.success(.data))
    }
    
    func delete(bookID: String, completion: @escaping RealmResult) {
        completion(.success(.data))
    }
    
    func update(bookID: String, completion: @escaping RealmResult) {
        completion(.success(.data))
    }
    
}
