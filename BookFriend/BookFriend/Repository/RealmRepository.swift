//
//  RealmRepository.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

class RealmRepository: RepositoryType {
    
    func create(completion: @escaping RealmResult) {
        completion(.success(.success(true)))
    }
    
    func read(completion: @escaping RealmResult) {
        completion(.success(.data([])))
    }
    
    func delete(with bookID: String, completion: @escaping RealmResult) {
        completion(.success(.success(true)))
    }
    
    func update(to bookID: String, completion: @escaping RealmResult) {
        completion(.success(.success(true)))
    }
    
}
