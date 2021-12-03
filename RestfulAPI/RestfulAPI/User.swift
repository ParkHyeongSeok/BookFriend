//
//  User.swift
//  RestfulAPI
//
//  Created by 박형석 on 2021/12/02.
//

import Foundation

struct User {
    let userID: Int
    let id: Int
    let title: String
    let body: String
}

struct Photo: Codable {
    
}

extension Photo {
    struct NetworkResult {
        var total: Int
        var total_pages: Int
        var result: [Photo]
    }
}
