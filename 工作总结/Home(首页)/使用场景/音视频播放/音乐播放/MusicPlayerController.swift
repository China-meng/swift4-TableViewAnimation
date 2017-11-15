//
//  MusicPlayerController.swift
//  工作总结
//
//  Created by mengxuanlong on 17/9/11.
//  Copyright © 2017年 mengxuanlong. All rights reserved.
//

import UIKit


class MusicPlayerController: UIViewController,PlayerManagerDelegate {
    lazy var musicsModel:[MusicsModel] = [MusicsModel]()

    var playerManager: PlayerManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initData()

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
extension MusicPlayerController {
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.white
  
    }
    fileprivate func initData(){
        //1.获取json文件的地址
        guard let jsonPath:String = Bundle.main.path(forResource: "gequ.json", ofType: nil) else {return}
        //2.获取json文件的数据
        guard let jsonData = NSData(contentsOfFile: jsonPath) else {return}
        //3.将json文件的数据转化为swift可读数据
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else {return}
        guard let dataArray = anyObject as? [[String:AnyObject]] else {return}
        for dict in dataArray{
            self.musicsModel.append(MusicsModel(dic:dict))
        }
        
        let currentMusic: MusicsModel? = self.musicsModel[0]
        //歌词
        printLog("currentMusic?.lrcname"+" --- \(String(describing: currentMusic?.lrcname))")
        guard let lrcPath = Bundle.main.path(forResource: currentMusic?.lrcname, ofType: nil) else {return}
        guard let lrcString = try? String(contentsOfFile: lrcPath) else {return}
        
       let iconStr = "http://y.gtimg.cn/music/photo_new/T002R500x500M0000032ezFm3F53yO.jpg?fromtag=127"
        
       playerManager = PlayerManager(playerFrame: CGRect(x: 0, y: 0, width: kScreenW, height: 210), contentView: self.view ,iconStr:iconStr , lrcStr: lrcString)
        view.addSubview(playerManager.playerView)
        playerManager.delegate = self
        
        
        // 音乐
        
        /*
         mp3是青花瓷抓的包,有可能会失效,可以自行更换
         歌词没有抓取到,因为歌词是本地的,所以歌词显示会有细微差距
         如果想要准确的把音频和视频同步,可以音频和歌词都加载本地的
         http://ws.stream.qqmusic.qq.com/105772207.m4a?fromtag=46
         
         http://124.193.230.17/amobile.music.tc.qq.com/C4000009BCJK1nRaad.m4a?vkey=7757473C56572B06FBD2CB8E043E29694E361B15053BDF23C2B32A4644E08E9734A6480CF3D7784CF86E3D8A09FF9CB44EEE47B299CA0ABA&guid=145C70C45C2F4BC68A39612C1FD2347D&uin=857813391&fromtag=127
         */
        playerManager.playUrlStr = "http://ws.stream.qqmusic.qq.com/105772207.m4a?fromtag=46"
 
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
