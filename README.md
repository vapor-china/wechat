<img src="images/banner.png"/>

[![Build Status](https://img.shields.io/badge/platforms-macOS%20%7C%20Ubuntu-green.svg)](https://github.com/vapor-china/wechat-pay)
[![Swift](https://img.shields.io/badge/Swift-5.2-orange.svg)](https://swift.org)
[![Swift](https://img.shields.io/badge/Vapor-4-orange.svg)](https://vapor.codes)
[![Xcode](https://img.shields.io/badge/Xcode-11.4-blue.svg)](https://developer.apple.com/xcode)
[![Xcode](https://img.shields.io/badge/macOS-15.0-blue.svg)](https://developer.apple.com/macOS)
[![MIT](https://img.shields.io/badge/licenses-MIT-red.svg)](https://opensource.org/licenses/MIT)



`Wechat` 是一个基于vapor4的微信SDK。支持 macOS, Ubuntu。

[English 📔](README_EN.md)

## 安装

### Swift Package Manager

要使用苹果的 Swift Package Manager 集成，将以下内容作为依赖添加到你的 `Package.swift`：

```swift
.package(url: "https://github.com/vapor-china/wechat.git", from: "2.0.0")
```

这里是一个 `PackageDescription` 实例：

```swift
// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "MyPackage",
    products: [
        .library(
            name: "MyPackage",
            targets: ["MyPackage"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor-china/wechat.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: [
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
            .product(name: "Vapor", package: "vapor"),
            .product(name: "Wechat", package: "wechat")
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
```

## 使用

### 注入wechat
```swift
        let mch = WechatConfiguare.MCH(mchId: "you mchId", secret: "your mch secret") // 如果不需要使用微信支付，这个可以设为nil
        let wechatConfig = try WechatConfiguare(appId: "your appid", appSecret: "your app secret", mch: mch)
        app.wechat.use(wechatConfig)
        
```

## 微信授权

### 获取 access token
```swift 
        try req.wechat.fetchUserAccessToken(code)
```

### 获取用户信息
```swift
        try req.wechat.getUserInfo(access: atk, openId: openid)
```

### 通过code直接获取用户信息示例
```swift
        try req.wechat.fetchUserAccessToken(code).flatMapThrowing({ (tokenModel) in
            if let errmsg = tokenModel.isErrMsg {
                throw RespError(err: .normal, msg: errmsg)
            }
            guard let atk = tokenModel.accessToken else { throw RespError(err: .normal, msg: "access token is not exists") }
            guard let openid = tokenModel.openId else { throw RespError(err: .normal, msg: "openid is not exists") }
            return try req.wechat.getUserInfo(access: atk, openId: openid).encodeResponse(for: req)
        }).flatMap { $0 }
```

### 刷新 access token
```swift 
        try req.wechat.refresh(access: token)
```

### 验证access token是否有效
```swift
        req.wechat.valid(access: token, openId: openId)
```

## 支付相关

### 支付预下单
```swift
        let param = WxPayUnifiedOrderPramas(outTradeNo: "macos\(Int(Date().timeIntervalSince1970))", body: "vapor test", totalFee: 1, spbillCreateIp: "127.0.0.1", notifyUrl: "http://notify.objcoding.com/notify", tradeType: .app)
         
        return try req.wechat.unified(order: param)
```

### 查询支付结果
```swift 
    	let param = WxPayOrderQueryPramas(outTradeNo: "your out trade no")
        try req.wechat.query(order: param)
```

### 关闭订单
```swift
    	let param = WxPayCloseOrderParams(outTradeNo: "your out trade no")
    	try req.wechat.close(order: param)
```

### 退款
```swift 
    	let param = WxPayRefundOrderParams(outTradeNo: "out trade no", outRefundNo: " out refund no", totalFee: 1, refundFee: 1, refundFeeType: "", refundDesc: "", refundAccount: "", notifyUrl: "http://notify.objcoding.com/notify")
        try req.wechat.refund(order: param)
```

### 支付回调解析处理
router请写post请求
```swift 
     		let res = try req.wechat.payCallback()
   				 ······
    		if res.isTransactionSuccess {
     			 return WxPayCallbackReturn.OK.encodeResponse(for: req)
   		  } else {
      		 return WxPayCallbackReturn.NotOK(errMsg: "msg").encodeResponse(for: req)
     		}   
```


## License

Wechat is released under an MIT license. See [License.md](https://github.com/vapor-china/wechat/blob/master/LICENSE) for more information.
