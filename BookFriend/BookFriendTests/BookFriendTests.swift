//
//  BookFriendTests.swift
//  BookFriendTests
//
//  Created by 박형석 on 2021/12/05.
//

import XCTest
@testable import BookFriend

class BookFriendTests: XCTestCase {
    
    private let BASE_URL = "https://openapi.naver.com/v1/search/blog.json"

    func test_makeURLwithComponents() {
        var components = URLComponents(string: BASE_URL)
        let catQuery = URLQueryItem(name: "query", value: "cat")
        components?.queryItems = [catQuery]
        guard let url = components?.url else {
            XCTFail("failed to convert url")
            return
        }
        XCTAssertEqual(url.absoluteString, "https://openapi.naver.com/v1/search/blog.json?query=cat")
    }
    
    func testRequest_searchBooksAndcompletionBooks() {
        let exp = expectation(description: "wait request and response Naver server")
        let networkManager = NetworkManager()
        networkManager.requestBooks(query: "life") { result in
            result.forEach { book in
                print(book.author)
                print(book.image)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10) { _ in
            
        }
    }
}
