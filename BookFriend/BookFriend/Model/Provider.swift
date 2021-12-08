//
//  Provider.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/06.
//

import Foundation

class Provider: ProviderProtocol {
    var realmRepository: RealmRepositoryType = RealmRepository()
    var networkManager: NetworkManagerType = NetworkManager()
}
