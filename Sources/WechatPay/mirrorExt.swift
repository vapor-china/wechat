//
//  File.swift
//  
//
//  Created by xj on 2020/4/1.
//

import Foundation

class MirrorExt {

    static func generateDic<T>(model: T) -> Dictionary<String,String> {

        var para : [String : String] = [:]

        var mirror: Mirror? = Mirror(reflecting: model)
        repeat {
            for (fkey,fval) in mirror!.children {
                print("\(String(describing: fkey))")
                if case Optional<Any>.none = fval {
//                    print("nil")
                    continue
                }
                print("\(String(describing: fkey)) -- \(fval)")
                let val = "\(fval)"
                if let key = fkey, val != "" {
                   para[key] = val
                }
            }
            mirror = mirror?.superclassMirror
        } while mirror != nil
        
        return para
    }
}
