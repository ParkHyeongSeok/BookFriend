//
//  NetworkingClients.swift
//  RestfulAPI
//
//  Created by 박형석 on 2021/12/02.
//

import Foundation
import Alamofire

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
    
    
    
}
