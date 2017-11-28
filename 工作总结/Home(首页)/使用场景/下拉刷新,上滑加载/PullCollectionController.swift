//
//  PullCollectionController.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/7/31.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit
import MJRefresh   // 顶部刷新
let header = MJRefreshNormalHeader()
// 底部刷新
let footer = MJRefreshAutoNormalFooter()
private let kItemMargin :CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kNormalCellID = "kNormalCellID"

class PullCollectionController: UIViewController {
    internal var list: [String] = []
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()

    fileprivate lazy var collectionView : UICollectionView = {[unowned self]in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        //组头
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
       // collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return collectionView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
      

        // 设置UI界面
        setupUI()
        // 请求数据
        getHttpData()
   
        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.collectionView.mj_header = header
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction:  #selector(footerRefresh))
        self.collectionView.mj_footer = footer
        

    }
    // 顶部刷新
    func headerRefresh(){
        print("下拉刷新")
        // 结束刷新
        collectionView.mj_header.endRefreshing()
        getHttpData()

    }
    func footerRefresh(){
        print("上拉刷新")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            for item in 11...20 {
                self.list.append(String(item))
            }
            self.collectionView.mj_footer.endRefreshing()
            
            self.collectionView.reloadData()
        }


        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

// MARK: - 设置UI界面内容
extension PullCollectionController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white

    }
}
// MARK:- 请求数据
extension PullCollectionController {
    fileprivate func getHttpData(){
        list.removeAll()
        print("网络请求")
        for item in 1...10 {
            list.append(String(item))
        }
        collectionView.reloadData()
 

  }
}

// MARK: UICollectionViewDataSource
extension PullCollectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list.count

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        cell.roomNameLabel.text = list[indexPath.row];
        return cell
    }

}

