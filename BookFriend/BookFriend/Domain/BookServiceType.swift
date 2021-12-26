//
//  BookServiceType.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/26.
//

import Foundation
import RxSwift

protocol BookServiceType: DomainProtocol where VALUE == Book {
    var memoryBookDB: [Book] { get set }
}
