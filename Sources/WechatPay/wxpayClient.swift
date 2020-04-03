//
//  File.swift
//  
//
//  Created by xj on 2020/3/31.
//

import Vapor
import AsyncHTTPClient

public struct WxpayClient {
    public init(appId: String, mchId: String, apiKey: String, isSandBox: Bool = false) {
        self.appId = appId
        self.mchId = mchId
        self.apiKey = apiKey
        self.isSandBox = isSandBox
    }
    
    let appId: String
    let mchId: String
    let apiKey: String
    var isSandBox: Bool
    
    public var signType = WxpayConst.SignType.md5
    
    public var httpConnectTimeout: Int64 = 3
    public var httpReadTimeout: Int64  = 1
}

public struct WxpayError: Error {
    
    var reason: String
    
    init(reason: String) {
        self.reason = reason
    }
    
}

extension WxpayError: CustomStringConvertible {
    public var description: String {
        return "the reason is: \(reason)"
    }
}


extension WxpayClient {
    
    public func postWithParam(url: WxpayConst.Url, params: WxPayParam, req: Request) throws -> EventLoopFuture<WxpayAppReqParams> {
        
        let dics = try generateParams(param: params)
        
        return req.client.post(URI(string: url.str)) { req in
            try req.content.encode(dics.xmlString)
        }.flatMapThrowing { res -> WxpayUnifiedOrderResponse in
            
            let result = try res.content.decode(WxpayUnifiedOrderResponse.self, using: XMLDecoder())
            if result.isSuccess {
                return result
            } else {
                throw WxpayError(reason: result.return_msg)
            }
            
        }.flatMapThrowing { (orderResult) -> (WxpayAppReqParams) in
            let timestamp = Int(Date().timeIntervalSince1970)
            var signParam = WxpayAppReqParams(appid: orderResult.appid, noncestr: orderResult.nonce_str, partnerid: orderResult.mch_id, prepayid: orderResult.prepay_id, timestamp: "\(timestamp)")
            let sign = try WxpaySign.sign(dic: MirrorExt.generateDic(model: signParam), key: self.apiKey, signType: self.signType).uppercased()
            signParam.sign = sign
            return signParam
        }
    }

}

// test
extension WxpayClient {
        
        func postWithParamDDD(url: WxpayConst.Url, params: WxPayParam) throws {
            
//            guard let loop = AppEventLoopGroup else { throw WxpayError(reason: "app event loop not exist") }
            
            let dics = try generateParams(param: params)
            
    //        let timeout = HTTPClient.Configuration.Timeout(connect: .seconds(httpConnectTimeout), read: .seconds(httpReadTimeout))
    //        let client = HTTPClient(eventLoopGroupProvider: .createNew)
            let client = HTTPClient(eventLoopGroupProvider: .createNew)
            defer {
                try? client.syncShutdown()
            }
            var request = try HTTPClient.Request(url: url.str, method: .POST)
            request.headers.add(name: HTTPHeaders.Name.contentType, value: "application/xml; charset=utf-8")
            request.body = .string(dics.xmlString)
            
            client.get(url: "http://api-test.szyimaikeji.com/user/me").whenComplete { (result) in
                print(result)
                switch result {
                case .failure(let err):
                    print(err)
                case .success(let resp):
                    print(resp)
                }
            }
            
    //        client.execute(request: request).whenComplete { (result) in
    //            switch result {
    //            case .failure(let error):
    //                print("error -----")
    //                print(error)
    //            case .success(let resp):
    //                if resp.status == .ok {
    //                    print("ok -----")
    //                    print(resp)
    //                    if let body = resp.body {
    //                        let data = body.getData(at: body.readerIndex, length: body.readableBytes)
    //                        if let data = data {
    //                            print(data)
    //                            let str = String(data: data, encoding: .utf8)
    //                            print(str ?? "convert data to str failure, line -- 60")
    //                        }
    //                    }
    //                } else {
    //                    print("failure -----")
    //                    print(resp)
    //                }
    //            }
    //
    //
    //        }
    //        try? client.syncShutdown()
    //        client.syncShutdown()
        }
}
