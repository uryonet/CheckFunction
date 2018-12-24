//
//  QiitaService.swift
//  CheckFunction
//
//  Created by 米山諒 on 2018/12/24.
//  Copyright © 2018 yoneyama ryo. All rights reserved.
//

import Foundation
import Hydra

class QiitaService {
    
    let qiitaApi = QiitaAPI()
    
    func loadQiitaAsync() -> Promise<QiitaItem> {
        return async({ _ -> QiitaItem in
            let qiitaItem = try await(QiitaAPI.getItem())
            return qiitaItem
        })
    }
    
}
