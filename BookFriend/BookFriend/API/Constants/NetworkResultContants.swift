//
//  NetworkResultContants.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

enum NetworkSuccess {
    case data([BookEntity])
}

enum NetworkError: Error {
    case emptyRequest
    case statusCode
    case emptyData
    case decodeError
    case urlRequest
}
