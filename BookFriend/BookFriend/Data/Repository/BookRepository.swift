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
        do {
            let bookRealmDTO = self.mapping(book)
            try self.realmDAO.create(value: bookRealmDTO)
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func delete(book: Book, completion: @escaping (Bool) -> Void) {
        do {
            let bookRealmDTO = self.mapping(book)
            try self.realmDAO.delete(key: bookRealmDTO.title)
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func search(with query: BookQuery, completion: @escaping BookResult) {
        do {
            let bookQueryRealmDTO = BookQueryRealmDTO(query: query.query)
            let result = try realmDAO.read(key: bookQueryRealmDTO.query)
            completion(.success(result.map { $0.toDomain() }))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetch(completion: @escaping BookResult) {
        
    }
}
