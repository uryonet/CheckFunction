//
//  APIClient.swift
//  CheckFunction
//
//  Created by 米山諒 on 2018/12/24.
//  Copyright © 2018 yoneyama ryo. All rights reserved.
//

import Foundation
import Alamofire
import Hydra

protocol RequestProtocol {
    associatedtype Response
    var baseUrl: String { get }
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding { get }
    var parameters: Alamofire.Parameters? { get }
    var headers: Alamofire.HTTPHeaders? { get }
}

// デフォルト設定値
extension RequestProtocol {
    var baseUrl: String {
        return "https://blog.uryo.net/"
    }
    var encoding: Alamofire.ParameterEncoding {
        return JSONEncoding.default
    }
    var parameters: Alamofire.Parameters? {
        return nil
    }
    var headers: Alamofire.HTTPHeaders? {
        return nil
    }
}
