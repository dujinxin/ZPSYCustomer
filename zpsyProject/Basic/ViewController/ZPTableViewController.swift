//
//  ZPTableViewController.swift
//  ZPOperator
//
//  Created by 杜进新 on 2017/7/1.
//  Copyright © 2017年 dujinxin. All rights reserved.
//

import UIKit
//import MJRefresh
//import MBProgressHUD

class ZPTableViewController: UITableViewController {

    var pageCount : Int = 1
    
    var backBlock : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "nav_return")
        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftItemsSupplementBackButton = false;
        let backBarButtonItem = UIBarButtonItem.init(title:"", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationController?.navigationBar.barTintColor = JXMainColor//导航条颜色
        self.navigationController?.navigationBar.tintColor = UIColor.white //item图片文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white/*,NSFontAttributeName:UIFont.systemFont(ofSize: 19)*/]//标题设置
        
        
        
//        _nav_return = @"nav_return";
//        self.interactivePopGestureRecognizer.enabled = YES;
//        self.interactivePopGestureRecognizer.delegate = (id)self;
//        [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
//        [self.navigationBar setBarTintColor:JXMainColor];
//        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//        self.navigationBar.shadowImage=[UIImage imageNamed:@""];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


}
extension ZPTableViewController {
    func showMBProgressHUD() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //        hud.backgroundView.color = UIColor.black
        //        hud.contentColor = UIColor.black
        //        hud.bezelView.backgroundColor = UIColor.black
        //        hud.label.text = "加载中..."
        
    }
    func hideMBProgressHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    /// request data
    func requestData() {
        
    }
    
    /// request data
    ///
    /// - Parameter withPage: load data for page,
    func request(with page:Int) {
        
    }
}
