//
//  BookListReactorUnitTests.swift
//  BookFriendTests
//
//  Created by 박형석 on 2021/12/15.
//

import XCTest
@testable import BookFriend

class BookListReactorUnitTests: XCTestCase {
    
    var reactor: BookListReactor!
    var bookVC: BookListViewController!

    override func setUpWithError() throws {
        let stubSession = StubURLSession(makeRequestFail: true, failStatusCode: false)
        let manager = NetworkManager(urlSession: stubSession)
        
        self.reactor = BookListReactor(manager: manager)
        self.reactor.isStubEnabled = true
        
        self.bookVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! BookListViewController
        self.bookVC.loadViewIfNeeded()
        self.bookVC.reactor = reactor
    }

    override func tearDownWithError() throws {
        reactor = nil
        bookVC = nil
    }
    
    // 테스트 내용 : 리액터의 상태가 바뀌엇을 때 뷰의 컴포넌트 속성이 잘 변경되는지 여부
    // 1) books: [Book]
    // 2) queryList: [String]
    // 3) isLoading:Bool
    func testReactorState_isLoading() {
        reactor.stub.state.value = BookListReactor.State(books: [], queryList: [], isLoading: true, query: "")
        XCTAssertEqual(bookVC.activityView.isAnimating, true)
    }
    
    func testReactorState_isNotLoading() {
        reactor.stub.state.value = BookListReactor.State(books: [], queryList: [], isLoading: false, query: "")
        XCTAssertEqual(bookVC.activityView.isAnimating, false)
    }
    
    func testReactorState_books() {
        let sampleBook = [
            Book(title: "title", link: URL(string: ""), image: URL(string: ""), author: "author", description: "description"),
            Book(title: "title2", link: URL(string: ""), image: URL(string: ""), author: "author2", description: "description2")
        ]
        reactor.stub.state.value = BookListReactor.State(books: sampleBook, queryList: [], isLoading: false, query: "")
        let tableViewCell = bookVC.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! BookListTableViewCell
        XCTAssertEqual(tableViewCell.bookTitle.text, sampleBook.first?.title)
    }
    
    func testReactorState_query() {
        reactor.stub.state.value = BookListReactor.State(books: [], queryList: ["Love"], isLoading: false, query: "")
        let collectionView = bookVC.collectionView
        let collectionViewCell = collectionView.dataSource?.collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as! QueryCollectionViewCell
        XCTAssertEqual(collectionViewCell.queryLabel.text, "Love")
    }
    
    // 사용자 인터랙션이 발생했을 때 Action이 리액터로 전달되는지 여부
    // searchButton Test
    func testReactorAction_WhenSearchButtonClicked_ThenMutationTakeSearch() {
        bookVC.searchController.searchBar.delegate?.searchBarSearchButtonClicked!(bookVC.searchController.searchBar)
        let action = reactor.stub.actions.last
    }
    
    // setQuery Test
    func testReactorAction_WhenTypingQuery_ThenMutationTakeQuery() {
        bookVC.searchController.searchBar.searchTextField.text = "Love"
        XCTAssertEqual(reactor.currentState.query, "Love")
    }

    

}
