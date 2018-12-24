//
//  CryptoViewController.swift
//  CheckFunction
//
//  Created by 米山諒 on 2018/12/23.
//  Copyright © 2018 yoneyama ryo. All rights reserved.
//

import UIKit
import Hydra

class CryptoViewController: UIViewController {
    
    @IBOutlet weak var keyString: UILabel!
    @IBOutlet weak var keyHash: UILabel!
    
    @IBOutlet weak var cyptoString: UILabel!
    @IBOutlet weak var decryptoString: UILabel!
    @IBOutlet weak var encryptoString: UILabel!
    
    private let qiitaService = QiitaService()
    let invalidator: InvalidationToken = InvalidationToken()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let keystr = "passwordpasswordpasswordpasswordinitialbaby".md5()
        let cryptostr = "etsryacas@gmail.com"
//        let iv = CryptoExtension.getInitializationVector()
        let iv = CryptoExtension.randomIv()
        guard let encryptostr = CryptoExtension.encrypt(plainString: cryptostr, key: keystr, iv: iv) else {
            print("1")
            return
        }
        print(encryptostr)
        if let decryptostr = CryptoExtension.decrypt(encryptedData: encryptostr, key: keystr, iv: iv) {
            print(decryptostr)
        }
        print("2")
    }
    
    @IBAction func decrypto(_ sender: UIButton) {
        async(token: invalidator, { status -> QiitaItem in
            let qiitaItems: QiitaItem = try await(self.qiitaService.loadQiitaAsync())
            Thread.sleep(forTimeInterval: 5.0)
            if status.isCancelled {
                print("cancelld")
                status.cancel()
            }
            print(qiitaItems)
            return qiitaItems
        }).then(in: .main) { result in
            print("最終結果：")
            print(result)
        }.catch(in: .main) { error in
            print(error)
        }
//        QiitaAPI.getItemTest()
    }
    
    @IBAction func encrypto(_ sender: UIButton) {
        invalidator.invalidate()
    }
    
}
