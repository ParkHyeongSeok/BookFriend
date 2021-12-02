//
//  UserListViewModel.swift
//  RestfulAPI
//
//  Created by 박형석 on 2021/12/02.
//

import Foundation

class UserListViewModel {
    
    var userBindingClosure: (() -> Void)?
    
    var userlist = [User]() {
        didSet {
            if let userBindingClosure = userBindingClosure {
                userBindingClosure()
            }
        }
    }
    
    var postURL: URL? {
        return URL(string: "https://jsonplaceholder.typicode.com/posts/1")
    }
    
    func fetchUserList() {
        NetworkingClient.shared.execute(postURL) { result, error in
            if let error = error {
                print(error)
            } else if let result = result {
                print(result)
            } else {
                print("fail")
            }
        }
    }
}
