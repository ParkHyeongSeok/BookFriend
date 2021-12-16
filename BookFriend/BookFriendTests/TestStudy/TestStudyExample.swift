//
//  TestStudyExample.swift
//  BookFriendTests
//
//  Created by 박형석 on 2021/12/14.
//

import XCTest
@testable import BookFriend

class TestStudyExample: XCTestCase {

    var dummyID: String!
    var dummyPassword: String!
    
    override func setUpWithError() throws {
        dummyID = "형석"
        dummyPassword = "456"
    }
    
    override func tearDownWithError() throws {
        dummyID = nil
        dummyPassword = nil
    }
    
    func testFetchUser_WhenUsingStub() {
        
        // 파라미터에 넣을 그냥 더미 객체, 객체만 필요O, 기능이 필요X
        let repository = OtherRepository()
        
        // 스텁을 이용한 테스트 : 특정 상태만 테스트
        let managerStub = NetworkManagerStub()
        let service = AccountService(manager: managerStub, repository: repository)
        
        let user = service.fetchUser(id: dummyID, password: dummyPassword)
        
        // 스텁을 통해 특정 상태(nil)을 고정하고 해당 값이 반영되는지를 테스트
        // 네트워크 스텁에는 nil을 반환하도록 구현, 테스트 통과
        XCTAssertNil(user)
        
    }
    
    func testFetchUser_WhenUsingFake() {
        // dummy
        let repository = OtherRepository()
        
        // Fake를 이용한 테스트 : 여러 상태를 테스트
        let fakeManager = FakeNetworkManager()
        let service = AccountService(manager: fakeManager, repository: repository)
        
        // DB에 있는 데이터 Fetch Test
        let user = service.fetchUser(id: "형석", password: "456")
        XCTAssertNotNil(user)
        XCTAssertEqual(user, User(dummyID, dummyPassword))
        
        let nilUser = service.fetchUser(id: "하연", password: "123")
        XCTAssertNil(nilUser)
        
        // DB에 데이터 넣기 Test
        service.createUser(id: "선아", password: "123")
        XCTAssertEqual(fakeManager.fakeDB.count, 2)
        
        service.createUser(id: "하연", password: "678")
        XCTAssertEqual(fakeManager.fakeDB.count, 3)
        
        // 기존 데이터 수정, 카운트 늘어나지 않는지 테스트
        service.createUser(id: "형석", password: "123")
        XCTAssertEqual(fakeManager.fakeDB.count, 3)
        
    }
    
    func testFetchAndCreateUser_WhenUsingSpy() {
        // dummy
        let repository = OtherRepository()
        let spy = NetworkManagerSpy()
        let service = AccountService(manager: spy, repository: repository)
        
        // 스파이 검증
        let _ = service.fetchUser(id: dummyID, password: dummyPassword)
        service.createUser(id: dummyID, password: dummyPassword)
        
        XCTAssertEqual(spy.createCallCount, 1)
        XCTAssertEqual(spy.fetchCallCount, 1)
        XCTAssertEqual(spy.checkIDAndPassword?.id, dummyID)
        XCTAssertEqual(spy.checkIDAndPassword?.password, dummyPassword)
    }
    
    func testFetchAndCreateUser_WhenUsingMock() {
        // dummy
        let repository = OtherRepository()
        let mock = TestNetworkManagerMock()
        let service = AccountService(manager: mock, repository: repository)
        service.createUser(id: "형석", password: "1234")
        let _ = service.fetchUser(id: "형석", password: "1234")
        
        mock.verifyCreate(callCount: 1, parameters: (id: "형석", password: "1234"))
        mock.verifyFetch(callCount: 1, parameters: (id: "형석", password: "1234"))
    }

}
