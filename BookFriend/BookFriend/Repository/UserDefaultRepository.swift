//
//  UserDefaultRepository.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/06.
//

import Foundation

class UserDefaultRepository: UserDefaultRepositoryType {
    
    func create(query: String, completion: @escaping UserDefaultResult) {
        completion(.success(.data))
    }
    
    func read(completion: @escaping UserDefaultResult) {
        
    }
    
    func delete(query: String, completion: @escaping UserDefaultResult) {
        
    }
}
