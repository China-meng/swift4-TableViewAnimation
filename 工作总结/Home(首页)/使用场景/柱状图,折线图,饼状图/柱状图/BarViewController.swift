//
//  BarViewController.swift
//  工作总结
//
//  Created by mengxuanlong on 2017/11/14.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class BarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension BarViewController {
    fileprivate func setupUI(){
        guard let jsonPath:String = Bundle.main.path(forResource: "zhuzhuang.json", ofType: nil) else {return}
        //2.获取json文件的数据
        guard let jsonData = NSData(contentsOfFile: jsonPath) else {return}
        //3.将json文件的数据转化为swift可读数据
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else {return}
        guard let dataDic = anyObject as? [String:Any] else {return}
        //printLog("数据"+" --- \(dataDic)")
        guard let resultData = dataDic["resultData"] as? [String:Any] else {return}
        
        guard let dataArray = resultData["progressList"] as? [[String : String]] else { return }
        printLog("dataArray"+" --- \(dataArray.count)")
        var barModelArr : [BarModel] = []
        for dict in dataArray {
            let model = BarModel(dic: dict)
            barModelArr.append(model)
        }
        
        printLog("个数"+" --- \(barModelArr.count)")
        
        var chartView : YHChartView = YHChartView()
        chartView = YHChartView(frame: CGRect(x: 0, y: 200, width: kScreenW, height: 410))
        chartView.loadData(YMaxValue: 1000, XValues: barModelArr, totalMoneyColor: UIColor.purple, title: "观影频次", bottomName: "各种卡")
        chartView.backgroundColor = UIColor.white
        view.addSubview(chartView)
        
        
    }

}
