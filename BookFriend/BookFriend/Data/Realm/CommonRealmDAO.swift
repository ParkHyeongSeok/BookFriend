//
//  CommonRealmDAO.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/26.
//

import Foundation
import RealmSwift

class CommonRealmDAO<VALUE: Object>: DAOProtocol {
    typealias KEY = String
    typealias VALUE = VALUE
    
    private var realm: Realm!
    
    init() {
        guard let realm = try? Realm(configuration: self.getRealmConfiguration(), queue: nil) else {
            fatalError("initialize failed.")
        }
        self.realm = realm
    }
    
    func getRealmConfiguration() -> Realm.Configuration {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { _, _ in }
        )
        Realm.Configuration.defaultConfiguration = config
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        return config
    }
    
    func create(value: VALUE) throws {
        do {
            try realm.write {
                realm.add(value)
            }
        } catch let error as NSError {
            throw DAOError.createFail(error.description)
        }
    }
    
    func read(key: KEY) throws -> [VALUE] {
        return []
//        return realm.objects(VALUE.self)
        
//        throw DAOError.readFail("not found \(key)")
    }
    
    func update(key: KEY, value: VALUE) throws {
        do {
            try realm.write({
                realm.add(value, update: .modified)
            })
        } catch {
            throw DAOError.updateFail(error.localizedDescription)
        }
    }
    
    func delete(key: KEY) throws {
        do {
            try realm.write({
                let value: VALUE = try read(key: key).first!
                realm.delete(value)
            })
        } catch {
            throw DAOError.deleteFail(error.localizedDescription)
        }
    }
    
}
