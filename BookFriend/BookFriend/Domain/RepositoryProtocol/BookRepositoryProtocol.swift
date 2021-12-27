//
//  BookRepositoryProtocol.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/27.
//

import Foundation

protocol BookRepositoryProtocol: DTOMapper {
    typealias BookResult = (Result<[Book], Error>) -> Void
    func save(book: Book, completion: @escaping (Bool) -> Void)
    func delete(book: Book, completion: @escaping (Bool) -> Void)
    func search(with query: BookQuery, completion: @escaping BookResult)
    func fetch(completion: @escaping BookResult)
}
