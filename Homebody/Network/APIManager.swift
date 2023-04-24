//
//  APIManager.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/30.
//

import Foundation
import Alamofire
import HandyJSON

final class APIManager {
    let decoder = JSONDecoder()
    static func request<T: HandyJSON>(_ url: String
                                      , method: HTTPMethod = .get
                                      , parameters: Parameters? = nil
                                      , headers: HTTPHeaders? = ["Content-Type": "application/json"]
                                      , encoding: ParameterEncoding = JSONEncoding.default
                                      , completion: @escaping (T?) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers) { $0.timeoutInterval = 15 }.responseJSON { response in
            switch response.result {
            case .success(let value):
                if let data = value as? NSDictionary, let model = T.deserialize(from: data) {
                    completion(model)
                }
                
            case .failure(let error):
                completion(nil)
                dump(error)
                break
            }
        }
    }
}
