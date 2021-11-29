//
//  NetworkManager.swift
//  RestfulAPI
//
//  Created by 박형석 on 2021/11/29.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    func sendRequest() {
        
        // alamofire에서 제공하는 [String:Any] Parameter(typealias)를 사용해서 파라미터 구현
        let parameters: Parameters = [
            "user_id" : "park",
            "user_pw" : "880623as"
        ]
        
        // 사용할 연결할 url
        // AF request에는 url을 String으로 넣어준다.
        // validate에서 statusCode는 정상 범위가 200~300 안이다.
        // http를 사용하기 위해서는 info.plist에서 App Transport Security Settings, Allow Arbitrary Loads를 세팅한다.
        
        // Alamofire 사용하기
        let dataRequest = AF.request(url,
                   method: .get,
                   encoder: JSONEncoding.default,
                   headers: [
                    "Content-Type" : "application/x=ww-font-wef"
                   ])
            .validate(statusCode: 200..<300)
        
        dataRequest.responseJSON { response in
            print(response)
            //Json으로 결과가 오는데 이 결과를 파싱해서 사용하면 된다.
        }
        
    }
    
    func getEvents(header: [String:Any], completion: @escaping (NetworkResult<Any>) -> Void){
        
        let url: String = "http://"
        
        requestGetData(url: url, httpmethod: .get, header: header, decodeType: String.self) {(completionData) in
                    completion(completionData)
        }
    }
            
    func getPromiseList(header: [String:Any], _ selectedDate: String, completion: @escaping (NetworkResult<Any>) -> Void){
        
        let url: String = "http://"
                
        requestGetData(url: url, httpmethod: .get, header: header, decodeType: String.self) {(completionData) in
                    completion(completionData)
        }
    }

    func judgeStatus<T : Codable>(by statusCode : Int, _ data : Data, _ decodeType : T.Type) -> Bool {
        let decoder = JSONDecoder()
            
        guard let decodedData = try? decoder.decode(decodeType, from: data) else{return .serverErr}
        
        switch statusCode {
        case 200: return .success(decodedData)
        case 400: return .requestErr(NetworkInfo.NO_DATA)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
        
    func requestGetData<T : Codable> (url : String, httpmethod : HTTPMethod, header : HTTPHeaders, decodeType : T.Type, completion: @escaping (NetworkResult<Any>) -> Void){

        let dataRequest = AF.request(url,
                                    method: httpmethod,
                                    encoding: JSONEncoding.default,
                                    headers: header).validate(statusCode: 200...500)
            
        dataRequest.responseData { response in
            switch response.result{
            case .success :
                guard let statusCode =  response.response?.statusCode else { return }
                guard let value =  response.value else{return}
                
                let networkResult = self.judgeStatus(by : statusCode, value, decodeType)
                
                completion(networkResult)
                
                case .failure:
                    completion(.serverErr)
            }
        }
    }
    
}
