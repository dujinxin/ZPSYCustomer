//
//  ScoreHistoryVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/22.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ScoreHistoryVC: UITableViewController {
    
    private var ScorelistArray:NSMutableArray? = []
    
    private var barImageView:UIView?
    private lazy var scoreLab:UILabel={
        let lab=UILabel()
        lab.font=UIFont.systemFont(ofSize: 19)
        lab.textColor=UIColor.white
        lab.textAlignment = NSTextAlignment.left
        lab.text = "\(UserManager.manager.userEntity.score)"
        return lab
    }()
    private lazy var headerImg : UIImageView = {
        let img = UIImageView()
        if let avatar = UserManager.manager.userEntity.avatar {
            img.sd_setImage(with: URL(string: avatar), placeholderImage: UIImage(named: PlaceHoldeImageStr))
        }
        
        img.layer.cornerRadius = 27*kScaleOfScreen
        img.layer.masksToBounds = true
        return img
    }()
    private lazy var nickNameLab:UILabel = {
        let lab = UILabel()
        lab.font=UIFont.systemFont(ofSize: 19)
        lab.textColor = UIColor.white
        lab.text = UserManager.manager.userEntity.nickName
        return lab
    }()
    private var pageno = 1
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        barImageView?.alpha=0
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        barImageView?.alpha=1;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="积分"
        barImageView = self.navigationController?.navigationBar.subviews.first
        barImageView?.alpha=0
        
        viewinit()
        rightBtninit()
        
        datarrequest()
    }

    func viewinit() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.sectionHeaderHeight=10
        self.tableView.sectionFooterHeight=1
        self.tableView.estimatedRowHeight=10
        self.tableView.isEditing=false
        self.tableView.estimatedSectionHeaderHeight=10
        self.tableView.contentInset=UIEdgeInsetsMake(-64, 0, 0, 0)
        self.tableView.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: {
            self.pageno+=1
            self.datarrequest()
        })
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.register(ScoreCell.self, forCellReuseIdentifier: "scorecellId")
        
        let imageview = UIImageView.init(image: UIImage.init(named: "scoreBg"))
        imageview.contentMode=UIViewContentMode.scaleToFill
        self.tableView.tableHeaderView=imageview
        
        
        imageview.addSubview(self.headerImg)
        self.headerImg.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(imageview.mas_top)?.offset()(64)
            let _ = make?.centerX.equalTo()(imageview)
            let _ = make?.size.equalTo()(CGSize.init(width: 54*kScaleOfScreen, height: 54*kScaleOfScreen))
        }
        
        imageview.addSubview(self.nickNameLab)
        self.nickNameLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.headerImg.mas_bottom)?.offset()(5)
            let _ = make?.centerX.mas_equalTo()(imageview)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        imageview.addSubview(lineView)
        lineView.mas_makeConstraints { (make:MASConstraintMaker?) in
            
            let _ = make?.centerX.mas_equalTo()(imageview)
            let _ = make?.top.mas_equalTo()(self.nickNameLab.mas_bottom)?.offset()(40*kScaleOfScreen)
            let _ = make?.bottom.mas_equalTo()(imageview.mas_bottom)?.offset()(-15)
            let _ = make?.width.equalTo()(1)
        }
        
        imageview.addSubview(self.scoreLab)
        self.scoreLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.centerY.mas_equalTo()(lineView)
            let _ = make?.left.mas_equalTo()(lineView.mas_right)?.offset()(15)
            let _ = make?.right.mas_equalTo()(imageview.mas_right)?.offset()(-15)
        }
        
        let totalLab=UILabel()
        totalLab.textColor=UIColor.white
        totalLab.font=UIFont.systemFont(ofSize: 18)
        totalLab.text="积分"
        totalLab.textAlignment=NSTextAlignment.right
        imageview.addSubview(totalLab)
        totalLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.centerY.mas_equalTo()(lineView)
            let _ = make?.left.mas_equalTo()(imageview.mas_left)?.offset()(15)
            let _ = make?.right.mas_equalTo()(lineView.mas_left)?.offset()(-15)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    private func datarrequest(){
    
        let dict = ["pageNo":pageno]
        MBProgressHUD.showAnimationtoView(self.view)
        BaseSeverHttp.zpsyGet(withPath: Api_GetScoreList, withParams: dict, withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: self.view)
            
            let arr:Array = scoreModel.mj_objectArray(withKeyValuesArray: result) as Array
            
            if self.pageno == 1 {
                self.ScorelistArray = NSMutableArray.init(array: arr)
            }else{
                self.ScorelistArray?.addObjects(from: arr)
            }
            
            self.tableView.reloadData()
            
        }) { (error:Error?) in
            MBProgressHUD.hide(for: self.view)
        }
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ScorelistArray?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:ScoreCell = tableView.dequeueReusableCell(withIdentifier: "scorecellId", for: indexPath) as! ScoreCell
        cell.scoremodel = self.ScorelistArray?.object(at: indexPath.row) as! scoreModel?
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func rightBtninit() {
        var image=UIImage.init(named: "help")
        image=image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let rightbaritem:UIBarButtonItem=UIBarButtonItem.init(image: image, style: UIBarButtonItemStyle.done, target: self, action:#selector(self.rightBtnClickEvent))
        self.navigationItem.rightBarButtonItem=rightbaritem
    }
    
    func rightBtnClickEvent() {
        let webview=WKwebVC.init()
        webview.urLstr=HtmlBasUrl + "integralRules"
        self.navigationController?.pushViewController(webview, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
