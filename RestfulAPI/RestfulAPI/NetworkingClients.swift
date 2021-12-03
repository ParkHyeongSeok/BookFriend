//
//  NetworkingClients.swift
//  RestfulAPI
//
//  Created by 박형석 on 2021/12/02.
//

import Foundation
import Alamofire

enum API {
    static let BASE_URL = "https://api.unsplash.com/"
    static let CLIENT_ID = "Qi4G9qPq4OGMycRtl3aHLlZNmCO99slGa3C9MDkj6rU"
}

class NetworkingClient {
    static let shared = NetworkingClient()
    
    typealias WebServuceResponse = ([[String:Any]]?, Error?) -> Void
    
    func execute(_ url: URL?, completion: @escaping WebServuceResponse) {
        
        guard let url = url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        AF.request(urlRequest)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if let error = response.error {
                    completion(nil, error)
                } else if let jsonArray = response.value as? [[String: Any]] {
                    completion(jsonArray, nil)
                } else if let jsonDict = response.value as? [String: Any] {
                    completion([jsonDict], nil)
                }
            }
    }
    
    func requestPhotos(query: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        
        guard let url = components.url else {
            // release 모드에서는 오류 출력 x
            preconditionFailure("Failed to construct URL")
        }
        
        let queryParameter = [
            "query": query,
            "client_id": API.CLIENT_ID
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: queryParameter)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                debugPrint(response)
            }
        
    }
    
    
    
}
