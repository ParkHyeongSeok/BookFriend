//
//  BookRepository.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/27.
//

import Foundation

class BookRepository: BookRepositoryProtocol {
    
    private let realmDAO: CommonRealmDAO<BookRealmDTO>
    private let networkManager: NetworkManagerType
    
    init(
        realmDAO: CommonRealmDAO<BookRealmDTO>,
        networkManager: NetworkManagerType
    ) {
        self.realmDAO = realmDAO
        self.networkManager = networkManager
    }
    
    func save(book: Book, completion: @escaping (Bool) -> Void) {
        
    }
    
    func delete(book: Book, completion: @escaping (Bool) -> Void) {
        
    }
    
    func search(with query: BookQuery, completion: @escaping BookResult) {
        
    }
    
    func fetch(completion: @escaping BookResult) {
        
    }
}
