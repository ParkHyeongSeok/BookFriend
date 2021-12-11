//
//  BookFriendUnitTests.swift
//  BookFriendTests
//
//  Created by 박형석 on 2021/12/08.
//

import XCTest
import Nimble
import Quick
@testable import BookFriend

class BookFriendUnitTests: XCTestCase {
    
    var networkManager: NetworkManagerType!

    override func setUpWithError() throws {
        self.networkManager = NetworkManager(urlSession: MockURLSession(makeRequestFail: false))
    }

    override func tearDownWithError() throws {
        self.networkManager = nil
    }
    
    func testComponentURLRequest() {
        
        let query = "Love"
        let httpMethod: HTTPMETHOD = .get
        let headers: [HTTPHEADER] = [
            HTTPHEADER(key: "client_id", value: "12345"),
            HTTPHEADER(key: "client_token", value: "ABCDEF")
        ]
        
        guard let urlRequest = networkManager._composedURLRequest(query: query, httpMethod: httpMethod, headers: headers) else {
            XCTFail("urlRequest is nil")
            return
        }
        
        XCTAssertEqual(
            urlRequest.url?.absoluteString,
            "https://openapi.naver.com/v1/search/book.json?query=Love")
        
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        
        guard let firstHeader = urlRequest.allHTTPHeaderFields else {
            XCTFail("urlRequest didn't have headers")
            return
        }
        XCTAssertEqual(
            firstHeader,
            [
                "client_id":"12345",
                "client_token":"ABCDEF"
            ])
    }
    
    func testURLSession_WhenPerformDataTask() {
        
    }
}


class MockURLSession: URLSessionType {
    
    let BASE_URL = URL(string: "https://openapi.naver.com/v1/search/book.json")!
    var testRequest: URLRequest?
    var sessionDataTast: MockURLSessionDataTask?
    var makeRequestFail = false
    
    init(makeRequestFail: Bool = false) {
        self.makeRequestFail = makeRequestFail
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
        
        let sessionDataTask = MockURLSessionDataTask()
        
        sessionDataTask.resumDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, failRange, nil)
            } else {
                completionHandler(nil, successRange, nil)
            }
        }
        return sessionDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    var resumDidCall : (() -> Void)?
    override init() { }
    override func resume() {
        if let resumDidCall = resumDidCall {
            resumDidCall()
        }
    }
}

