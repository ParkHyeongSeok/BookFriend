//
//  URLSessionType.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/08.
//

import Foundation

protocol URLSessionType {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionType {
    
}
