//
//  VideoPlayerController.swift
//  工作总结
//
//  Created by mengxuanlong on 17/9/11.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit

class VideoPlayerController: UIViewController,PlayerManagerDelegate {
    var playerManager: PlayerManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

// MARK: - 设置UI界面
extension VideoPlayerController {
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.white
        playerManager = PlayerManager(playerFrame: CGRect(x: 0, y: 0, width: kScreenW, height: 210), contentView: self.view ,iconStr:"" , lrcStr: "")
        view.addSubview(playerManager.playerView)
        playerManager.delegate = self
    
        // 视频
        playerManager.playUrlStr = "http://baobab.wdjcdn.com/1457162012752491010143.mp4"
 
        playerManager.seekToTime(0)// 跳转至第N秒的进度位置，从头播放则是0
        playerManager.play()
    }
    

    
    // MARK:- PlayerManagerDelegate
    // 返回按钮点击回调
    func playerViewBack() {
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    // 分享按钮点击回调
    func playerViewShare() {
        print("处理分享逻辑")
    }
    
    // 播放完成回调
    func playFinished() {
        print("播放完了😁")
    }
    
}
