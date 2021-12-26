//
//  DomainProtocol.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/26.
//

import Foundation
import RxSwift

protocol DomainProtocol {
    associatedtype KEY
    associatedtype VALUE
    func create()
    func getAll()
}
