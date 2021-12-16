//
//  TestExampleModel.swift
//  BookFriendTests
//
//  Created by 박형석 on 2021/12/14.
//

import Foundation
import XCTest

// Model
class User {
    let id: String
    let password: String
    init(_ id: String, _ password: String) {
        self.id = id
        self.password = password
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

// 그냥 더미 객체
class OtherRepository {
    func settings() {
        // ...
    }
}

// 실제 DB
var realDB = [
    "선아":"123",
    "형석":"456"
]

// Protocol로 Manager 간접화
protocol TestNetworkManagerType {
    func createUser(id: String, password: String)
    func fetchUser(id: String, password: String) -> User?
}

// 실제 DB와 통신하는 Manager
class TestNetworkManager: TestNetworkManagerType {
    func createUser(id: String, password: String) {
        realDB[id] = password
    }
    
    func fetchUser(id: String, password: String) -> User? {
        if realDB[id] == password {
            return User(id, password)
        } else {
            return nil
        }
    }
}

// Stub
// 실제로 동작하는 것처럼 보이게 만들어 놓은 객체
class NetworkManagerStub: TestNetworkManagerType {
    
    // 메시지 출력
    func createUser(id: String, password: String) {
        print(id)
        print(password)
    }
    
    // 특정 상태 -> 실제 DB와 통신하지 않고 그냥 DB에 해당 내역이 없다는 '실패 상태'를 표현. nil을 하드 코딩한 상태. id나 password를 변경한다고 해서 다른 상태를 반환하지 않음. 즉 행위 검증이 아닌 상태 검증일 뿐
    func fetchUser(id: String, password: String) -> User? {
        return nil
    }
}

// Fake
// 실제 로직이 수행되고 다양한 상태를 반영할 수 있도록 구현한다.
class FakeNetworkManager: TestNetworkManagerType {
    
    // 객체 내부에 실제와 동일한 모양으로 상태 변화를 반영하도록 구축
    // 가짜 DB 사용
    var fakeDB = ["형석":"456"]
    
    func createUser(id: String, password: String) {
        fakeDB[id] = password
    }
    
    // 실제처럼 구현하지만 완전 실제X (물론 여기는 fakeDB를 제외하면 동일)
    func fetchUser(id: String, password: String) -> User? {
        if fakeDB[id] == password {
            return User(id, password)
        } else {
            return nil
        }
    }
}

// Spy
// 테스트에서 사용되는 개체, 메소드의 사용 여부 및 정상 호출 여부를 기록하고 요청시 알려줌
// 테스트 더블에 스파이처럼 잠입해서 위의 내용을 기록
class NetworkManagerSpy: TestNetworkManagerType {
    
    // 특정 테스트 메서드가 몇번 호출 되었는지 필요한 경우 전역 변수로 카운트를 설정
    public var createCallCount: Int = 0
    public var fetchCallCount: Int = 0
    
    // 가장 최근에 생성된 아이디와 패스워드 기록
    public var checkIDAndPassword: (id: String, password: String)?
    
    func createUser(id: String, password: String) {
        createCallCount += 1
        checkIDAndPassword = (id: id, password: password)
    }
    
    func fetchUser(id: String, password: String) -> User? {
        fetchCallCount += 1
        return nil
    }
    
    // 특정 메소드가 호출 되었을 때 또 다른 메서드가 실행이 되어야 한다와 같은 행위 기반 테스트가 필요한 경우 사용한다.
}

// Mock
// 테스트 내용
// fist useCase : 서비스에서 유저 생성하기
// 파라미터가 정상 전달 되는지, 한 번의 호출로 목적을 이룰 수 있는지, 해당 파라미터로 정상적인 생성이 가능한지, DB에 잘 저장이 되는지
// second useCase : 서비스에서 유저 가져오기
// 파라미터가 정상 전달 되는지, 한 번의 호출로 목적을 이룰 수 이는지, 해당 파라미터로 정상적인 가져오기가 가능한지
class TestNetworkManagerMock: TestNetworkManagerType {
    typealias Account = (id: String, password: String)
    
    // 스파이의 기록, 스텁의 가짜 데이터까지 모두 검증해서 테스트의 결과까지 내어놓는 객체
    private var fakeDB = [String:String]()
    private var createCallCount: Int = 0
    private var fetchCallCount: Int = 0
    private var createIDAndPassword: Account?
    private var fetchIDAndPassword: Account?
    
    func createUser(id: String, password: String) {
        createCallCount += 1
        createIDAndPassword = (id: id, password: password)
        fakeDB[id] = password
    }
    
    func fetchUser(id: String, password: String) -> User? {
        fetchCallCount += 1
        fetchIDAndPassword = (id: id, password: password)
        if fakeDB[id] == password {
            return User(id, password)
        } else {
            return nil
        }
    }
    
    // mock은 총체적 행동으로 테스트를 자체적으로 성공, 실패시킬 수 있음
    func verifyCreate(
        callCount: Int,
        parameters: Account,
        file: StaticString = #file,
        line: UInt = #line) {
            XCTAssertEqual(createCallCount, callCount,
                           "call count", file: file, line: line)
            XCTAssertEqual(createIDAndPassword?.id, parameters.id,
                           "valid id", file: file, line: line)
            XCTAssertEqual(createIDAndPassword?.password, parameters.password,
                           "valid password", file: file, line: line)
            let valid = fakeDB.contains { data in
                data.key == parameters.id
            }
            XCTAssertTrue(valid, "isCreateed", file: file, line: line)
        }
    
    func verifyFetch(
        callCount: Int,
        parameters: Account,
        file: StaticString = #file,
        line: UInt = #line) {
            XCTAssertEqual(fetchCallCount, callCount)
            XCTAssertEqual(fetchIDAndPassword?.id, parameters.id,
                           "valid id", file: file, line: line)
            XCTAssertEqual(fetchIDAndPassword?.password, parameters.password,
                           "valid password", file: file, line: line)
            XCTAssertEqual(fakeDB[parameters.id], parameters.password,
                           "valid fetch", file: file, line: line)
        }
}


// 사용자 데이터 읽기 쓰기 비지니스 로직을 담당하는 서비스 + 의존성 주입
class AccountService {
    
    let repository: OtherRepository
    let manager: TestNetworkManagerType
    init(manager: TestNetworkManagerType,
         repository: OtherRepository) {
        self.manager = manager
        self.repository = repository
    }
    
    func createUser(id: String, password: String) {
        manager.createUser(id: id, password: password)
    }
    
    func fetchUser(id: String, password: String) -> User? {
        return manager.fetchUser(id: id, password: password)
    }
}
