//
//  DataAssembly.swift
//  BookFriend
//
//  Created by 박형석 on 2022/01/09.
//

import Foundation
import Swinject

class DataAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(URLSessionType.self ) { resolver in
            return URLSession.shared
        }
        
        container.register(NetworkManagerType.self) { resolver in
            return DefaultNetworkManager(urlSession: resolver.resolve(URLSessionType.self)!)
        }
        
        container.register(DAOProtocol.self) { resolver in
            return CommonRealmDAO()
        }
        
    }
}
