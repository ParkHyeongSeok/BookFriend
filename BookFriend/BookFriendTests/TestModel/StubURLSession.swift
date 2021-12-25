//
//  StubURLSession.swift
//  BookFriendTests
//
//  Created by 박형석 on 2021/12/15.
//

import Foundation
@testable import BookFriend

class StubURLSession: URLSessionType {
    
    let BASE_URL = URL(string: "https://openapi.naver.com/v1/search/book.json")!
    var testRequest: URLRequest?
    var sessionDataTast: StubURLSessionDataTask?
    var makeRequestFail = false
    var failStatusCode: Bool = false
    
    init(makeRequestFail: Bool = false,
         failStatusCode: Bool) {
        self.makeRequestFail = makeRequestFail
        self.failStatusCode = failStatusCode
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let successRange = HTTPURLResponse(url: BASE_URL,
                                           statusCode: 200,
                                           httpVersion: "2",
                                           headerFields: nil)
        
        let failRange = HTTPURLResponse(url: BASE_URL,
                                           statusCode: 410,
                                           httpVersion: "2",
                                           headerFields: nil)
        
        let failRangeNil = HTTPURLResponse(url: BASE_URL,
                                           statusCode: 200,
                                           httpVersion: "2",
                                           headerFields: nil)
        
        let sessionDataTask = StubURLSessionDataTask()
        
        let sampleBook = [
            BookEntity(title: "title", link: URL(string: ""), image: URL(string: ""), author: "author", description: "description"),
            BookEntity(title: "title2", link: URL(string: ""), image: URL(string: ""), author: "author2", description: "description2")
        ]
        let response = NetworkResponse<BookEntity>(items: sampleBook)
        let sampleData = try? JSONEncoder().encode(response)
        
        // 결과에 대한 특정한 상태 값만 배출
        sessionDataTask.resumDidCall = {
            if self.makeRequestFail {
                completionHandler(sampleData, successRange, nil)
            } else if self.failStatusCode {
                completionHandler(sampleData, failRange, NetworkError.statusCode)
            } else {
                completionHandler(nil, failRangeNil, NetworkError.emptyData)
            }
        }
        return sessionDataTask
    }
}

class StubURLSessionDataTask: URLSessionDataTask {
    var resumDidCall : (() -> Void)?
    override func resume() {
        if let resumDidCall = resumDidCall {
            resumDidCall()
        }
    }
}

