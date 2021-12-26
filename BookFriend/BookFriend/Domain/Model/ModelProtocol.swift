//
//  DomainModelProtocol.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/26.
//

import Foundation

protocol DomainModel {
    associatedtype NETWORKENTITY
    associatedtype REALMENTITY
    func mapping(to entity: NETWORKENTITY)
    func mapping(to entity: REALMENTITY)
}

protocol PersistentEntityMapper {
    associatedtype ENTITY
    func convert() -> ENTITY
}
