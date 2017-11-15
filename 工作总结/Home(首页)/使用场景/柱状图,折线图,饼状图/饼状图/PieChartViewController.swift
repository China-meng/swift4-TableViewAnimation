//
//  PieChartViewController.swift
//  工作总结
//
//  Created by mengxuanlong on 2017/11/14.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class PieChartViewController: UIViewController {
    lazy var formatter:NumberFormatter = {
        let a = NumberFormatter()
        a.numberStyle = .percent
        a.maximumFractionDigits = 0
        a.multiplier = 1
        a.percentSymbol = "%"
        return a
    }()
    var months = ["1-9", "10-19", "20-29", "30-39","40-49", "50-59", "60-69", "70以上"]
    var unitsSold = [30.0, 100.0, 108.0, 60.0, 50.0, 160.0, 187.0, 60.0]
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
