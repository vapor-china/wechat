//
//  File.swift
//  
//
//  Created by xj on 2020/4/14.
//

import Vapor


// test
extension WxPayClient {
        
        func postWithParamDDD(url: WxPayConst.Url, params: WxPayParam) throws {
            
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
