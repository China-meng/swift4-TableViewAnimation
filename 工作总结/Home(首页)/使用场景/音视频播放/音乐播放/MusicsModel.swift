//
//  MusicsModel.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/8/12.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class MusicsModel: NSObject {
    ///歌曲名称
    var name: String = ""
    ///歌曲对应的文件名称
    var filename: String = ""
    ///歌词对应的文件名称
    var lrcname: String = ""
    ///歌手名字
    var singer: String = ""
    ///歌手的大图片
    var singerIcon: String = ""
    ///歌手的小图片
    var icon: String = ""
    
    //自定义构造函数
    init(dic: [String: Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
