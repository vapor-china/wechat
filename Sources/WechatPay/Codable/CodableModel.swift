//
//  File.swift
//  
//
//  Created by xj on 2020/5/16.
//

import Foundation
public protocol CodableModel {
    init(from decoder: Decoder) throws
}
