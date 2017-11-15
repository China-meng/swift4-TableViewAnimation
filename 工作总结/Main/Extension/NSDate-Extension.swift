//
//  NSDate-Extension.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/6/29.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() ->String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }

}
