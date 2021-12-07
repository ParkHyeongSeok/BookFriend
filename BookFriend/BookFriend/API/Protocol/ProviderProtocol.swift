//
//  ProviderProtocol.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/06.
//

import Foundation

protocol ProviderProtocol {
    var realmRepository: RealmRepositoryType { get }
    var networkManager: NetworkManagerType { get }
}
