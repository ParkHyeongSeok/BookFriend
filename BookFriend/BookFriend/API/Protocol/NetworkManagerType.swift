//
//  NetworkManagerType.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/06.
//

import Foundation

protocol NetworkManagerType {
    func requestBooks(query: String, completion: @escaping (Result<[Book], NetworkError>) -> Void)
    func _composedURLRequest(query: String, httpMethod: HTTPMETHOD?, headers: [HTTPHEADER]?) -> URLRequest?
}
