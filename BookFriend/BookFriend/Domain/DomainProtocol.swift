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
    func save(_ value: VALUE) -> Observable<Bool>
    func fetchAll() -> Observable<[VALUE]>
    func fetch(_ key: KEY) -> Observable<VALUE>
    func update(_ key: KEY, _ value: VALUE) -> Observable<Bool>
    func delete(_ key: KEY) -> Observable<Bool>
}
