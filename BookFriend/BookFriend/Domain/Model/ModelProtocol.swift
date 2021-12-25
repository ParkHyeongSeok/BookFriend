//
//  DomainModelProtocol.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/26.
//

import Foundation

protocol DomainModel {
    associatedtype ENTITY
    func mapping(to entity: ENTITY)
}
