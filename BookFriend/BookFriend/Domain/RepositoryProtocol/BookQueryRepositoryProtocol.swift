//
//  BookQueryRepositoryProtocol.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/27.
//

import Foundation

protocol BookQueryRepositoryProtocol {
    typealias BookQueryResult = (Result< [BookQuery], Error>) -> Void
    func fetchQueries(completion: @escaping BookQueryResult)
    func saveRecentQuery(query: BookQuery, completion: @escaping (Bool) -> Void)
}
