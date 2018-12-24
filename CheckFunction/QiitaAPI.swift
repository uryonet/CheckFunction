//
//  QiitaAPI.swift
//  CheckFunction
//
//  Created by 米山諒 on 2018/12/24.
//  Copyright © 2018 yoneyama ryo. All rights reserved.
//

import Foundation
import Alamofire
import Hydra

class QiitaAPI {
    
    enum APIError: Error {
        case connectionError
        case serverError(ErrorEntity)
    }
    
    let parameters: Parameters = [
        "page" : 1,
        "per_page" : 20,
        "query" : "qiita user:yaott"
    ]
    
    static func getItem() -> Promise<QiitaItem> {
        print("process getItem")
        return Promise<QiitaItem>(in: .background, { resolve, reject, _ in
            
            Alamofire.request("https://blog.uryo.net/test.json", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { response in
                print("process")
                if let data = response.data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let result: QiitaItem = try? decoder.decode(QiitaItem.self, from: data) {
                        print(result)
                        resolve(result)
                    }
                } else {
                    reject(APIError.connectionError)
                }
            }
        })
    }
    
    static func getItemTest() {
        print("process getItemTest")
        Alamofire.request("https://blog.uryo.net/test.json", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { response in
            print("process")
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let data = response.data else {
                    print(APIError.connectionError)
                    return
                }
                switch response.response?.statusCode {
                case 200:
                    print(data)
                    if let result: QiitaItem = try? decoder.decode(QiitaItem.self, from: data) {
                        print(result)
                    }
                case 504:
                    print(data)
                    if let result: ErrorEntity = try? decoder.decode(ErrorEntity.self, from: data) {
                        print(APIError.serverError(result))
                    }
                default:
                    print(APIError.connectionError)
                }
            case .failure:
                print(APIError.connectionError)
            }
        }
    }
    
    
//    func addProduct(product: MainProduct, completionHandler: @escaping ((JSON?, Error?)->Void)) {
//
//        let encoder = JSONEncoder()
//        let jsonData = try! encoder.encode(product)
//
//        let url = "INSERT_URL"
//
//        var request = URLRequest(url: url)
//        request.httpMethod = HTTPMethod.put.rawValue
//        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
//
//        Alamofire.request(request).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                print ("finish")
//                let swiftyJson = JSON(value)
//                completionHandler(swiftyJson, nil)
//            case .failure(let error):
//                completionHandler(nil, error)
//            }
//        }
//    }
    
}
