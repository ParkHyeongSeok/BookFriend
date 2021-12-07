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
        case deleteQueryList
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setBooks([Book])
        case setQueryList([String])
        case setQuery(String)
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
                self.search(query: query).map { Mutation.setBooks($0) },
                Observable.just(.setLoading(false))
            ])
        case .deleteQueryList:
            let query = self.currentState.query
            provider.userDefaultRepository.delete(query: query, completion: { _ in })
            return .empty()
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
        case .setQueryList(let queryList):
            newState.queryList = queryList
        }
        return newState
    }
    
    private func search(query: String) -> Observable<[Book]> {
        return Observable.create { (observer) -> Disposable in
            self.provider.userDefaultRepository.create(query: query) { result in
                switch result {
                case .success(_):
                    self.provider.networkManager.requestBooks(query: query) { books in
                        observer.onNext(books)
                        observer.onCompleted()
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
}
