//
//  CryptoExtension.swift
//  CheckFunction
//
//  Created by 米山諒 on 2018/12/23.
//  Copyright © 2018 yoneyama ryo. All rights reserved.
//
//  参考URL
//  https://gist.github.com/hfossli/7165dc023a10046e2322b0ce74c596f8
//  https://qiita.com/dq-shuhei-ohno/items/f1ccdc33468e612ef6cb

import Foundation
import CommonCrypto

struct CryptoExtension {
    
    /// 暗号
    public static func encrypt(plainString: String, key: String, iv: Data) -> Data? {
        guard let keyData = key.md5().data(using: .utf8) else {
            return nil
        }
        guard let data = plainString.data(using: .utf8) else {
            return nil
        }

        // 暗号化後のデータのサイズを計算
        let cryptLength = size_t(Int(ceil(Double(data.count / kCCBlockSizeAES128)) + 1.0) * kCCBlockSizeAES128)

        var cryptData = Data(count:cryptLength)
        var numBytesEncrypted: size_t = 0

        // 暗号化
        let cryptStatus = cryptData.withUnsafeMutableBytes {cryptBytes in
            iv.withUnsafeBytes {ivBytes in
                data.withUnsafeBytes {dataBytes in
                    keyData.withUnsafeBytes {keyBytes in
                        CCCrypt(CCOperation(kCCEncrypt),
                                CCAlgorithm(kCCAlgorithmAES),
                                CCOptions(kCCOptionPKCS7Padding),
                                keyBytes, keyData.count,
                                ivBytes,
                                dataBytes, data.count,
                                cryptBytes, cryptLength,
                                &numBytesEncrypted)
                    }
                }
            }
        }

        if UInt32(cryptStatus) != UInt32(kCCSuccess) {
            return nil
        }
        return cryptData
    }

    /// 復号
    public static func decrypt(encryptedData: Data, key: String, iv: Data) -> String? {
        guard let keyData = key.md5().data(using: .utf8) else {
            return nil
        }

        let clearLength = size_t(encryptedData.count + kCCBlockSizeAES128)
        var clearData   = Data(count:clearLength)

        var numBytesEncrypted :size_t = 0

        // 復号
        let cryptStatus = clearData.withUnsafeMutableBytes {clearBytes in
            iv.withUnsafeBytes {ivBytes in
                encryptedData.withUnsafeBytes {dataBytes in
                    keyData.withUnsafeBytes {keyBytes in
                        CCCrypt(CCOperation(kCCDecrypt),
                                CCAlgorithm(kCCAlgorithmAES),
                                CCOptions(kCCOptionPKCS7Padding),
                                keyBytes, keyData.count,
                                ivBytes,
                                dataBytes, encryptedData.count,
                                clearBytes, clearLength,
                                &numBytesEncrypted)
                    }
                }
            }
        }

        if UInt32(cryptStatus) != UInt32(kCCSuccess) {
            print("decrypt1")
            return nil
        }

        // パディングされていた文字数分のデータを捨てて文字列変換を行う
        guard let decryptedStr = String(data: clearData, encoding: .utf8) else {
            print("decrypt2")
            return nil
        }
        return decryptedStr
    }
    
    // ランダムなIVを作成する
    static func randomIv() -> Data {
        return randomData(length: kCCBlockSizeAES128)
    }

    private static func randomData(length: Int) -> Data {
        var data = Data(count: length)
        let status = data.withUnsafeMutableBytes { mutableBytes in
            SecRandomCopyBytes(kSecRandomDefault, length, mutableBytes)
        }
        assert(status == Int32(0))
        return data
    }
    
}

extension String {
    public func md5() -> String {
        var md5String = ""
        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
        let md5Buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: digestLength)
        
        if let data = self.data(using: .utf8) {
            data.withUnsafeBytes({ (bytes: UnsafePointer<CChar>) -> Void in
                CC_MD5(bytes, CC_LONG(data.count), md5Buffer)
                md5String = (0..<digestLength).reduce("") { $0 + String(format:"%02x", md5Buffer[$1]) }
            })
        }
        
        return md5String
    }
}
