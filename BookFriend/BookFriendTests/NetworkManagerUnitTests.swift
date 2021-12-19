//
//  NetworkManagerUnitTests.swift
//  BookFriendTests
//
//  Created by 박형석 on 2021/12/08.
//

import XCTest
@testable import BookFriend

class NetworkManagerUnitTests: XCTestCase {
    
    var networkManager: NetworkManagerType!
    var urlRequest: URLRequest!
    
    override func setUpWithError() throws {
        let query = "Love"
        let httpMethod: HTTPMETHOD = .get
        self.networkManager = NetworkManager(urlSession: StubURLSession(makeRequestFail: false, failStatusCode: true))
        self.urlRequest = networkManager._composedURLRequest(query: query, httpMethod: httpMethod)
        
    }

    override func tearDownWithError() throws {
        self.urlRequest = nil
        self.networkManager = nil
    }
    
    // 테스트 목적 : _composedURLRequest의 정상 작동 여부 -> 올바른 URLRequest를 반환하는가?
    // 다른 의존성이 없기 때문에 Sociable Test
    func testComponentURLRequest() {
        guard let testRequst = networkManager._composedURLRequest(query: "Love", httpMethod: .get) else {
            XCTFail("urlRequest is nil")
            return
        }
        
        XCTAssertEqual(
            testRequst.url?.absoluteString,
            "https://openapi.naver.com/v1/search/book.json?query=Love")
        XCTAssertEqual(testRequst.httpMethod, "GET")
    }
    
    // 테스트 목적 : networkManager의 requestBooks 작동 여부 체크
    // URLSession Stub에서 관련 fail(statusCodeError) 여부 조사
    func testURLSession_WhenPerformDataTask_StatusCodeError() {
        let exp = expectation(description: "waiting urlsession")
        self.networkManager.requestBooks(with: urlRequest) { result in
            switch result {
            case .success(_):
                XCTFail("fetch some books")
            case .failure(let error):
                exp.fulfill()
                XCTAssertEqual(error, NetworkError.statusCode)
            }
        }
        waitForExpectations(timeout: 5.0) { error in
            print("expectation catched Error : \(String(describing: error))")
        }
    }
    
    // URLSession Stub에서 관련 fail(emptyDataError) 여부 조사
    func testURLSession_WhenPerformDataTask_DataEmpryError() {
        let exp = expectation(description: "waiting urlsession")
        self.networkManager = NetworkManager(urlSession: StubURLSession(makeRequestFail: false, failStatusCode: false))
        self.networkManager.requestBooks(with: urlRequest) { result in
            switch result {
            case .success(_):
                XCTFail("fetch some books")
            case .failure(let error):
                exp.fulfill()
                XCTAssertEqual(error, NetworkError.emptyData)
            }
        }
        waitForExpectations(timeout: 5.0) { error in
            print("expectation catched Error : \(String(describing: error))")
        }
    }
    
    func testURLSession_WhenPerformDataTask_SuccessResponse() {
        let exp = expectation(description: "waiting urlsession")
        let sampleBook = Book(title: "title", link: URL(string: ""), image: URL(string: ""), author: "author", description: "description")
        self.networkManager = NetworkManager(urlSession: StubURLSession(makeRequestFail: true, failStatusCode: false))
        self.networkManager.requestBooks(with: urlRequest) { result in
            switch result {
            case .success(let books):
                exp.fulfill()
                XCTAssertNotNil(books)
                XCTAssertEqual(books.first, sampleBook)
            case .failure(let error):
                XCTFail("fetch some books : \(String(describing: error))")
            }
        }
        waitForExpectations(timeout: 5.0) { error in
            print("expectation catched Error : \(String(describing: error))")
        }
    }
}
