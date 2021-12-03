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
        NetworkingClient.shared.requestPhotos(query: "cat") { result in
            switch result {
            case .success(let photos):
                print(photos)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
