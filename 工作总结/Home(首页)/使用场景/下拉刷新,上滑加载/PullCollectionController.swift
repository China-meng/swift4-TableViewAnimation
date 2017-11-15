//
//  PullCollectionController.swift
//  斗鱼直播
//
//  Created by mengxuanlong on 17/7/31.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

private let kItemMargin :CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kNormalCellID = "kNormalCellID"

class PullCollectionController: UIViewController {
    internal var list: [String] = []

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
        pullRefreshHttpData()
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
        print("1 秒后输出")
        for item in 1...10 {
            list.append(String(item))
        }
 

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
// MARK:- 下拉刷新
extension PullCollectionController {
    fileprivate func pullRefreshHttpData() {
        
        // 下拉刷新
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "refresh.gif", withExtension: nil)!)
        let textItem = TextItem(normalText: VerticalHintText.headerNomalText, pullingText: VerticalHintText.headerPullingText, refreshingText: VerticalHintText.headerRefreshText, nomoreDataText: nil, font: UIFont.systemFont(ofSize: 13), color: UIColor.black)
        
        
        collectionView.sy_header = GifTextHeaderFooter(data: data,textItem:textItem, orientation: .top, height: 60,contentMode:.scaleAspectFit,completion: { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self?.getHttpData()
                self?.collectionView.sy_header?.endRefreshing()
                self?.collectionView.reloadData()
            }

        })
        
        
        let textItem2 = TextItem(normalText: VerticalHintText.footerNomalText, pullingText: VerticalHintText.footerPullingText, refreshingText: VerticalHintText.footerRefreshText, nomoreDataText:nil ,font: UIFont.systemFont(ofSize: 13), color: UIColor.black)
        collectionView.sy_footer = GifTextHeaderFooter(data: data,textItem:textItem2, orientation: .bottom, height: 60,contentMode:.scaleAspectFit,completion: { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                for item in 11...20 {
                    self?.list.append(String(item))
                }
                self?.collectionView.sy_footer?.endRefreshing()
                self?.collectionView.reloadData()
            }
        })

        
    }
}
