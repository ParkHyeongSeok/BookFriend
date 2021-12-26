//
//  PersistentEntityProtocol.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/26.
//

import Foundation

protocol PersistentEntity {
    associatedtype MODEL
    func mapping(to model: MODEL)
}

protocol DomainModelMapper {
    associatedtype MODEL
    func convert() -> MODEL
}
