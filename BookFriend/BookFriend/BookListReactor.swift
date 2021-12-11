//
//  BookListReactor.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/06.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit

class BookListReactor: Reactor {
    
    enum Action {
        case inputQuery(String)
        case searchButtonClicked
        case cancelButtonClicked
        case deleteQueryList(String)
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setBooks([Book])
        case setQueryList(String)
        case setQuery(String)
        case deleteQuery(String)
    }
    
    struct State {
        var books = [Book]()
        var queryList = [String]()
        var isLoading = false
        var query = ""
    }
    
    let initialState: State
    let provider: ProviderProtocol
    
    init(provider: ProviderProtocol) {
        self.provider = provider
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputQuery(let query):
            return .just(Mutation.setQuery(query))
        case .searchButtonClicked:
            let query = self.currentState.query
            return Observable.concat([
                Observable.just(.setLoading(true)),
                .just(Mutation.setQueryList(query)),
                self.search(query: query).map { Mutation.setBooks($0) },
                Observable.just(.setLoading(false))
            ])
        case .deleteQueryList(let query):
            return .just(Mutation.deleteQuery(query))
        case .cancelButtonClicked:
            return Observable.concat([
                .just(Mutation.setQuery("")),
                .just(Mutation.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoading(let isLoding):
            newState.isLoading = isLoding
        case .setQuery(let query):
            newState.query = query
        case .setBooks(let books):
            newState.books = books
        case .setQueryList(let query):
            newState.queryList.append(query)
        case .deleteQuery(let query):
            if let index = self.currentState.queryList.firstIndex(of: query) {
                newState.queryList.remove(at: index)
            }
        }
        return newState
    }
    
    private func search(query: String) -> Observable<[Book]> {
        return Observable.create { (observer) -> Disposable in
            self.provider.networkManager.requestBooks(query: query) { result in
                switch result {
                case .success(let books):
                    guard !books.isEmpty else {
                        observer.onError(NSError(domain: "search", code: 400, userInfo: nil))
                        return
                    }
                    observer.onNext(books)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
}
