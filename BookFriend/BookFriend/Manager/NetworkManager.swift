//
//  NetworkManager.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import Foundation

class NetworkManager {
    
    private var session : URLSession {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }
    
    func requestBooks(query: String, completion: @escaping ([Book]) -> Void) {
        
        let headers = [
            HTTPHEADER(key: "X-Naver-Client-Id", value: "9FsWrUJnsC8i6U2FRplD"),
            HTTPHEADER(key: "X-Naver-Client-Secret", value: "mtkUonNIla")
        ]
        
        guard let urlRequest = self.composedURLRequest(query: query, httpMethod: .get, headers: headers) else {
            return
        }
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  (200..<300).contains(statusCode) else { return }
            if let data = data {
                do {
                    let books = try JSONDecoder().decode(NetworkResponse<Book>.self, from: data)
                    completion(books.items)
                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    private func composedURLRequest(query: String, httpMethod: HTTPMETHOD?, headers: [HTTPHEADER]?) -> URLRequest? {
        
        let BASE_URL = "https://openapi.naver.com/v1/search/book.json"
        
        var components = URLComponents(string: BASE_URL)
        let newQuery = URLQueryItem(name: "query", value: query)
        components?.queryItems = [newQuery]
        
        guard let url = components?.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod?.rawValue
        headers?.forEach({ header in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        })
        
        return urlRequest
    }
    
}
