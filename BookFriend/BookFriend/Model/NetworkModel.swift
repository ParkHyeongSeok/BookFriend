//
//  NetworkModel.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

enum HTTPMETHOD: String {
    case get = "GET"
}

struct HTTPHEADER {
    var key: String
    var value: String
}

struct NetworkResponse<Wrapper: Decodable>: Decodable {
    var items: [Wrapper]
}
