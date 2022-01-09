//
//  DAOType.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/25.
//

import Foundation

// Persistent Layer : 데이터 저장 계층

// DAO(Data Access Object)
// Database의 data에 access하는 트랜잭션 객체(CRUD)
// Domain logic으로부터 Persistence mechanism을 숨기기 위해 사용
// 장점 : 효율적인 커넥션 관리 및 보안성

// 기존에는 이 작업을 일일이 하드코딩해서 만듬
// 하지만 DAO라는 객체를 만들어 필요한 곳에 사용하고 관련 Entity에 필요한 기능(mapping for business)을 추가해놓으면 굳이 더 많은 코드가 필요하지 않음

protocol DAOProtocol {
    associatedtype KEY
    associatedtype VALUE
    func create(value: VALUE) throws
    func read(key: KEY) throws -> [VALUE]
    func update(key: KEY, value: VALUE) throws
    func delete(key: KEY) throws
}

enum DAOError: Error {
    case createFail(String)
    case readFail(String)
    case updateFail(String)
    case deleteFail(String)
}

