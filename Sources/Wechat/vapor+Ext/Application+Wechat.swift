//
//  File.swift
//  
//
//  Created by xj on 2020/5/15.
//

import Vapor

extension Application {
    public var wechat: Wechat {
        .init(application: self)
    }
    
    public struct Wechat {
        
        private final class Storage {
            var client: WxPayClient
            init(client: WxPayClient) {
                self.client = client
            }
        }
        
        private struct Key: StorageKey {
            typealias Value = Storage
        }
        private struct ConfigKey: StorageKey {
            typealias Value = WechatConfiguare
        }
        
        private var storage: Storage {
            if let existing = self.application.storage[Key.self] {
                return existing
            } else {
                guard let config = configuration else {
                    fatalError("No Wechat Configuration. Configure with app.wehcat.use(...)")
                }
                let wxClient = WxPayClient(appId: config.appId, appSecret: config.appSecret, mchId: config.mch?.mchId, mchSecret: config.mch?.mchSecret)
                let new = Storage(client: wxClient)
                self.application.storage[Key.self] = new
                return new
            }
        }
        
        public var client: WxPayClient {
            self.storage.client
        }
        
        
        public func use(_ config: WechatConfiguare) {
            configuration = config
        }
        
        
        private var configuration: WechatConfiguare? {
            get {
                self.application.storage[ConfigKey.self]
            }
            nonmutating set {
                self.application.storage[ConfigKey.self] = newValue
            }
        }
        
        let application: Application
    }
}

public struct WechatConfiguare {
    let appId: String
    let appSecret: String?
    let mch: MCH?
    
    public struct MCH {
        let mchId: String
        let mchSecret: String
    }
    
    
    public init(appId: String, appSecret: String? = nil, mch: MCH? = nil) throws {
        guard !appId.isEmpty else { fatalError("config appid can't is empty") }
        self.appId = appId
        self.appSecret = appSecret
        self.mch = mch
    }
}
