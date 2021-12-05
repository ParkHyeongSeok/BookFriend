//
//  RealmResultConstants.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

enum RealmSuccess {
    case success(Bool)
    case data([Book])
}

enum RealmFailure: Error {
    case failure
}
