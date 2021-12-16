//
//  NetworkManager.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

class NetworkManager: NetworkManagerType {
    
    let urlSession: URLSessionType
    
    init(urlSession: URLSessionType) {
        self.urlSession = urlSession
    }
    
    func requestBooks(with urlRequest: URLRequest, completion: @escaping (Result<[Book], NetworkError>) -> Void) {
        let task = self.urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  (200..<300).contains(statusCode) else {
                      completion(.failure(NetworkError.statusCode))
                      return }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return }
            
            do {
                let books = try JSONDecoder().decode(NetworkResponse<Book>.self, from: data)
                completion(.success(books.items))
            } catch {
                completion(.failure(NetworkError.decodeError))
            }
        }
        task.resume()
    }
    
    func _composedURLRequest(query: String, httpMethod: HTTPMETHOD?) -> URLRequest? {
        
        let BASE_URL = "https://openapi.naver.com/v1/search/book.json"
        
        let headers = [
            HTTPHEADER(key: "X-Naver-Client-Id", value: "9FsWrUJnsC8i6U2FRplD"),
            HTTPHEADER(key: "X-Naver-Client-Secret", value: "mtkUonNIla")
        ]
        
        var components = URLComponents(string: BASE_URL)
        let newQuery = URLQueryItem(name: "query", value: query)
        components?.queryItems = [newQuery]
        guard let url = components?.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod?.rawValue
        headers.forEach({ header in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        })
        return urlRequest
    }
    
}
