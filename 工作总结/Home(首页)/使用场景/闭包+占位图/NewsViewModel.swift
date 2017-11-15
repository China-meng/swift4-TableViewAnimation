//
//  NewsViewModel.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/7/29.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class NewsViewModel: NSObject {
     lazy var newsModels:[NewsModel] = [NewsModel]()


}
extension NewsViewModel {
    func getNewsHttpData(_ finishCallback : @escaping () -> ()) {
        NetworkTools.requestHttpData(type: .get, URLString: "http://c.m.163.com/nc/article/list/T1348649079062/0-20.html", parameters: nil) { (result :Any) in
//            print(result)
            guard let resultDict = result as? [String: Any] else { return }
            //[[String : Any]] 最外面是数组,数组里面存的字典
            guard let dataArray = resultDict["T1348649079062"] as? [[String : Any]] else { return }
            //3遍历数组,取出字典,字典转模型
            for dict in dataArray {
                self.newsModels.append(NewsModel(dic:dict))
            }
            finishCallback()

        }
    }
}
