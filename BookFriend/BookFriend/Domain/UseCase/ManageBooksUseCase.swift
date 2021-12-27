//
//  ManageBooksUseCase.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/27.
//

import Foundation
import RxSwift

protocol ManageBooksUseCase {
    func save(book: Book) -> Observable<Bool>
    func delete(book: Book) -> Observable<Bool>
    func fetch() -> Observable<[Book]>
    func search(with query: BookQuery) -> Observable<[Book]>
}

class DefaultManageBooksUseCase: ManageBooksUseCase {
    
    private let bookRepository: BookRepositoryProtocol
    private let bookQueryRepository: BookQueryRepositoryProtocol
    
    init(
        bookRepository: BookRepositoryProtocol,
        bookQueryRepository: BookQueryRepositoryProtocol
    ) {
        self.bookRepository = bookRepository
        self.bookQueryRepository = bookQueryRepository
    }
    
    func save(book: Book) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            self.bookRepository.save(book: book) { success in
                observer.onNext(success)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func delete(book: Book) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            self.bookRepository.delete(book: book) { success in
                observer.onNext(success)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func fetch() -> Observable<[Book]> {
        return Observable<[Book]>.create { observer in
            self.bookRepository.fetch { result in
                switch result {
                case .success(let books):
                    observer.onNext(books)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func search(with query: BookQuery) -> Observable<[Book]> {
        return Observable<[Book]>.create { observer in
            self.bookRepository.search(with: query) { result in
                switch result {
                case .success(let books):
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
