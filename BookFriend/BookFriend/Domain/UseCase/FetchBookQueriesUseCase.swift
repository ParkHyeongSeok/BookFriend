//
//  FetchBookQueriesUseCase.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/27.
//

import Foundation
import RxSwift

protocol FetchBookQueriesUseCase {
    func execute() -> Observable<[BookQuery]>
}

class DefaultFetchBookQueriesUseCase: FetchBookQueriesUseCase {
    
    private let bookQueryRepository: BookQueryRepositoryProtocol
    
    init(
        bookQueryRepository: BookQueryRepositoryProtocol
    ) {
        self.bookQueryRepository = bookQueryRepository
    }
    
    func execute() -> Observable<[BookQuery]> {
        return Observable<[BookQuery]>.create { observer in
            self.bookQueryRepository.fetchQueries { result in
                switch result {
                case .success(let quries):
                    observer.onNext(quries)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
