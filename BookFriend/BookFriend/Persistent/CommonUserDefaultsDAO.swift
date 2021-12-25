//
//  CommonUserDefaultsDAO.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/25.
//

import Foundation


class CommonUserDefaultsDAO<VALUE: PersistentEntity>: DAOProtocol {
    typealias KEY = String
    typealias VALUE = VALUE
    
    let userDefaults = UserDefaults.standard
    
    func create(key: KEY, value: VALUE) throws {
        self.userDefaults.set(value, forKey: key)
    }
    
    func read(key: String) throws -> VALUE {
        guard let value = userDefaults.object(forKey: key) as? VALUE else {
            throw DAOError.readFail("UserDefaults read Error")
        }
        return value
    }
    
    func update(key: String, value: VALUE) throws {
        do {
            try self.delete(key: key)
            try self.create(key: key, value: value)
        } catch {
            throw DAOError.updateFail("UserDefault update Error")
        }
        
    }
    
    func delete(key: String) throws {
        self.userDefaults.removeObject(forKey: key)
    }
    
}
