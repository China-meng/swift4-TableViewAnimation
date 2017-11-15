//
//  PlaceholderController.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/7/29.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
private let kHomeCell = "kHomeCell"

class PlaceholderController: UIViewController {
    lazy var toastView : MMToastView = MMToastView()

    fileprivate lazy var newsVM :NewsViewModel = NewsViewModel()
    fileprivate lazy var newsModels:[NewsModel] = [NewsModel]()
    
    var refreshControl = UIRefreshControl()
    var timer: Timer!

    // MARK: - 懒加载tableView
    fileprivate lazy var tableView :BaseTableView = {[unowned self]in
        let tableView = BaseTableView()
        tableView.frame = self.view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
        
        tableView.register(UINib(nibName: "NewTableViewCell", bundle: nil), forCellReuseIdentifier: kHomeCell)
        return tableView
        }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI界面
        setupUI()
     
        // 请求数据
        getHttpData()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

// MARK: - 设置UI界面内容
extension PlaceholderController {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        view.addSubview(toastView)
        refreshControl.addTarget(self, action: #selector(refreshControlMethod), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")

    }
    func refreshControlMethod(){
        self.newsVM.newsModels.removeAll()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeOut), userInfo: nil, repeats: true)
    }
    func timeOut(){
        getHttpData()
        print("新闻数据个数 -- ",self.newsVM.newsModels.count)
        if  self.newsVM.newsModels.count > 0 {
            tableView.reloadData()
            refreshControl.endRefreshing()
            
            timer.invalidate()
            timer = nil
        }
    }

}

// MARK:- 请求数据
extension PlaceholderController {
    fileprivate func getHttpData() {
        newsVM.getNewsHttpData { [unowned self]in
            /****测试是否显示占位图***/
            //self.newsVM.newsModels.removeAll(keepingCapacity: true)
            
            if self.newsVM.newsModels.count > 0 {
                self.tableView.removeEmptyView()
                self.newsModels = self.newsVM.newsModels
                self.tableView.addSubview(self.refreshControl)

            } else {
                self.tableView.showEmptyView()
  
                self.tableView.placeholderView.labelClickCallBack = { () -> () in
                    print("vc重新加载数据")
                    let string = "暂无数据暂无数据暂无数据暂无数据暂无数据"
                    self.toastView.showBottomOnlyTextToast(string, autoRemove: true)

                    self.getHttpData()
                }
                

            }
            self.tableView.reloadData()
            
        }
        
    }
}


// MARK: - 实现UITableView的数据源方法
extension PlaceholderController : UITableViewDataSource , UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModels.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kHomeCell, for: indexPath) as! NewTableViewCell
        //        cell.textLabel?.text = newsModels[indexPath.row].title
        cell.newsModel = newsModels[indexPath.row]
        return cell
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !refreshControl.isRefreshing {
            if scrollView.contentOffset.y > -150 {
                refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
                
            } else {
                refreshControl.attributedTitle = NSAttributedString(string: "数据加载中......")
                
            }
        }
        
        
    }

    
}
extension PlaceholderController :UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.y)
//
//    }
    //滚动视图开始拖动
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print(" == ",scrollView.contentOffset.y)
//
//
//    }
}
