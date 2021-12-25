//
//  UserService.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/26.
//

import Foundation

protocol UserServiceType: DomainProtocol {
    var userDAO: CommonUserDefaultsDAO { get set }
}

class UserService: UserServiceType {
    
}
