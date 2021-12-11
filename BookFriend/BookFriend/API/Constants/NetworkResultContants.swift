//
//  NetworkResultContants.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

enum NetworkSuccess {
    case result(String)
    case data([Book])
}

enum NetworkFailure {
    case none
}

enum NetworkError: Error {
    case emptyRequest
    case statusCode
    case emptyData
    case decodeError
}
