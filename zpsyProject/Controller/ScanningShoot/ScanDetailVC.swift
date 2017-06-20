//
//  ScanDetailVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/28.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ScanDetailVC: UIViewController{
    
    public var scanfinishmodel:scanFinishModel? = scanFinishModel()
    
    private lazy var tableView:ScanDetailView={
    
        let tableview=ScanDetailView.init(frame: CGRect.init(x: 0, y: 49, width: kScreenWidth, height: kScreenHeight-49), style: UITableViewStyle.plain)
        return tableview;
    }()
    
    private lazy var lineWhiteView : UIView = {
    
        let view = UIView.init(frame: CGRect.init(x: kScreenWidth/4.0-40, y: 47, width: 80, height: 2))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var SegmentBtn:UISegmentedControl={
        let segment=UISegmentedControl.init(items: ["识真假","比价格"])
        segment.frame=CGRect.init(x: 0, y: 64, width: kScreenWidth, height: 49)
        segment.tintColor = UIColor.clear
        segment.backgroundColor = kColor_red
        
        segment.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 16),NSForegroundColorAttributeName:UIColor.white], for: UIControlState.selected)
        segment.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 16),NSForegroundColorAttributeName:UIColor.init(white: 1, alpha: 0.5)], for: UIControlState.normal)
        segment.selectedSegmentIndex=0
        return segment
    }()

    private var offsetPre_y:CGFloat = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="正品溯源"

        rightBtnset()
        
        self.tableView.scanfinishmodel = scanfinishmodel
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.SegmentBtn)
        
        let statusView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 20))
        statusView.backgroundColor = kColor_red
        self.view.addSubview(statusView)
        
        
        self.SegmentBtn.addSubview(self.lineWhiteView)
        self.SegmentBtn.rac_signal(for: UIControlEvents.valueChanged).subscribeNext {[weak self] (segment:Any?) in
            self?.tableView.selectedSegmentIndex = (self?.SegmentBtn.selectedSegmentIndex)!
            if self?.SegmentBtn.selectedSegmentIndex == 1{
                self?.lineWhiteView.x = kScreenWidth/4.0*3-40;
            }else{
                self?.lineWhiteView.x = kScreenWidth/4.0-40;
            }
        }
        
//        let inputview=CommentInputView.init(true)
//        inputview.resourcesId = self.scanfinishmodel?.proDetailModel?.ID
//        inputview.Mycommenttype = commentType.commentProduct
//        self.view.addSubview(inputview)
//        inputview.mas_makeConstraints { (make:MASConstraintMaker?) in
//            let _ = make?.left.mas_equalTo()(self.view.mas_left);
//            let _ = make?.right.mas_equalTo()(self.view.mas_right);
//            let _ = make?.bottom.mas_equalTo()(self.view.mas_bottom);
//            let _ = make?.top.mas_equalTo()(self.tableView.mas_bottom);
//        }
        
        self.tableView.scrollDIdScrollBlock = {[weak self](offset_Y:CGFloat)->Void in
            self?.offsetyDateSet(offset_Y)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.backgroundCenter), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
    }

    @objc private func backgroundCenter(){
        self.resetfram(20)
    }
    
    private func offsetyDateSet(_ offset_Y:CGFloat){
    
        if let navigationController = self.navigationController {
            let dat_Y:CGFloat = offset_Y - self.offsetPre_y
            var nav_y:CGFloat = (navigationController.navigationBar.y)
            nav_y -= dat_Y
            nav_y = nav_y>20 ? 20:nav_y
            nav_y = nav_y<(-44) ? (-44):nav_y
            self.resetfram(nav_y)
            self.offsetPre_y = offset_Y;
        }
    }
    
    private func resetfram(_ nav_y:CGFloat){
        self.navigationController?.navigationBar.y = nav_y
        var dat_nav:CGFloat = nav_y - 20
        dat_nav = dat_nav < (-44) ? (-44) : dat_nav
        self.tableView.y = 49+dat_nav;
        self.tableView.height = kScreenHeight-49-dat_nav
        self.SegmentBtn.y = dat_nav+64
        self.offsetPre_y = self.tableView.contentOffset.y
    }
    
    deinit {
        debugPrint("ddddddd")
    }
    private func rightBtnset() -> Void {
        
        let bar_1 = UIBarButtonItem.init(image: UIImage.init(named: "whitecollection"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.collectionsBtnClickEvent))
        
        let bar_2 = UIBarButtonItem.init(image: UIImage.init(named: "whiteShare"), style: UIBarButtonItemStyle.done, target: self, action: #selector(self.shareFun))
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItems = [bar_2,bar_1]
        
    }
    //收藏
    @objc private func collectionsBtnClickEvent(){
        
        if !UserModel.shareInstance().isLogin {
            let login = LoginVC.init()
            self.present(login, animated: true, completion: nil)
            return
        }
        
        
        MBProgressHUD.showAnimationtoView(self.view)
        BaseSeverHttp.zpsyGet(withPath: Api_userFavorites , withParams: ["resourceId":self.scanfinishmodel?.proDetailModel?.ID ?? "","flag":"0","type":"0"], withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: self.view)
            MBProgressHUD.showSuccess("收藏成功!")
        }) { (err:Error?) in
            MBProgressHUD.hide(for: self.view)
        }
        
    }
    
    /// 分享
    @objc private func shareFun(){
        
        if !UserModel.shareInstance().isLogin {
            let login = LoginVC.init()
            self.present(login, animated: true, completion: nil)
            return
        }
        
        let shareModel = ShareViewModel()
        shareModel.title = (self.scanfinishmodel?.proDetailModel?.name)! + ":看见真实的幸福"
        shareModel.desText = self.scanfinishmodel?.proDetailModel?.remarks
        shareModel.urlStr = self.scanfinishmodel?.proDetailModel?.jumpUrl
        shareModel.icon = self.scanfinishmodel?.proDetailModel?.getfirstGoodImg()
        let shareview = UShareView.init(model: shareModel)
        weak var weakShare = shareview;
        shareview?.shareresult={(error:Error?) -> Void in
            if error != nil {
                weakShare?.hidden()
                MBProgressHUD.showError("分享失败")
            }else{
                weakShare?.hidden()
                BaseSeverHttp.zpsyGet(withPath: Api_userScoreChange, withParams: ["type":"4"], withSuccessBlock: nil, withFailurBlock: nil)
            }
        }
        shareview?.show()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resetfram(20)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.resetfram(20)
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.resetfram(20)
        super.viewDidDisappear(animated)
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
