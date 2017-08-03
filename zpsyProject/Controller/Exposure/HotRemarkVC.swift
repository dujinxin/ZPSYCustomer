//
//  HotRemarkVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/20.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class HotRemarkVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    
    public var resourcesId : String? = ""
    
    public var objectcCommentType:String? {
        didSet{
            if objectcCommentType == "1" {
                mycommenttype = commentType.commentExpouse
            }else if objectcCommentType == "2"{
                mycommenttype = commentType.commentPrefrence
            }
        }
    }
    
    public var mycommenttype:commentType? = commentType.commentProduct
    
    private var pageNo = 1
    private var ListArray:NSMutableArray = NSMutableArray.init()
    
    private var remarkNum:String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="热点评论"
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate=self
        self.tableView.dataSource=self
        
        RemarkInputInit()
        
        self.tableView.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: { 
            self.pageNo+=1
            self.datarequest()
        })
        self.datarequest()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    private func datarequest(){
        
        let dict = ["pageNo":pageNo,"id":self.resourcesId ?? "","type":self.mycommenttype?.rawValue ?? 0,"isforHotFive":false] as [String : Any]
        MBProgressHUD.showAnimationtoView(self.view)
        
        BaseSeverHttp.zpsyGet(withPath: Api_commentGetComment, withParams: dict, withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: self.view)
            let resultDict:NSDictionary = result as! NSDictionary
            self.remarkNum = (resultDict["sum"] as! NSNumber).stringValue
            let arr:NSArray = hotremarkModel.mj_objectArray(withKeyValuesArray: resultDict["list_comment"])
            if self.pageNo == 1{
                self.ListArray = NSMutableArray.init(array: arr)
            }else{
                self.ListArray.addObjects(from: arr as! [Any])
            }
            self.tableView.reloadData()
        }) { (err:Error?) in
            MBProgressHUD.hide(for: self.view)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //mark# 初始化
    func RemarkInputInit() {
        
        let inputview=CommentInputView.init(true)
        inputview.Mycommenttype = self.mycommenttype
        inputview.resourcesId = self.resourcesId
        inputview.successBlock = {[weak self]()->Void in
            self?.pageNo = 1
            self?.datarequest()
        }
        self.view.addSubview(inputview)
        inputview.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.view.mas_left);
            let _ = make?.right.mas_equalTo()(self.view.mas_right);
            let _ = make?.bottom.mas_equalTo()(self.view.mas_bottom);
            let _ = make?.top.mas_equalTo()(self.tableView.mas_bottom);
        }
        
    }
    
    
    
    
    private lazy var tableView:UITableView = {
        
        let tableview=UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-60), style: UITableViewStyle.grouped)
        tableview.register(HotRemarkCell.self, forCellReuseIdentifier: "RemarkCellID")
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "identierfieder")
        tableview.estimatedRowHeight=10
        tableview.rowHeight=UITableViewAutomaticDimension
        return tableview
    }()
    

    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ListArray.count + 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row==0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "identierfieder")
            cell?.selectionStyle=UITableViewCellSelectionStyle.none
            cell?.textLabel?.text="评论(" + self.remarkNum + ")"
            return cell!
        }else{
            let cell:HotRemarkCell = tableView.dequeueReusableCell(withIdentifier: "RemarkCellID", for: indexPath)as! HotRemarkCell
            let model:hotremarkModel = self.ListArray[indexPath.row-1] as! hotremarkModel
            cell.MyImageView.sd_setImage(with: URL.init(string: model.avatar ?? ""), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            cell.myTitleLab.text = model.nickName
            cell.myLikeLab.text = model.praiseNum
            cell.myDetLab.text = model.content
            cell.myTimeLab.text = CTUtility.string(from: model.createDateStr, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy年MM月dd日 HH:mm")
            cell.praiseClickBlock = {[weak self]()->Void in
                self?.praiseclickEvent(indexPath.row-1)
            }
            return cell
        }
    }
    
    private func praiseclickEvent(_ row :NSInteger) -> Void {
    
        var Type = ""
        if self.mycommenttype == commentType.commentProduct {
            Type = "0"
        }else if self.mycommenttype == commentType.commentExpouse {
            Type = "2"
        }else{
            Type = "4"
        }
        let model:hotremarkModel = self.ListArray[row] as! hotremarkModel
        let dict = ["id":model.ID,"type":Type]
        MBProgressHUD.showAnimationtoView(self.view)
        BaseSeverHttp.zpsyGet(withPath: Api_praiseCommitPraise, withParams: dict, withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: self.view)
            
            var num:NSInteger = NSInteger.init(model.praiseNum!)!
            num+=1
            model.praiseNum = NSString.init(format: "%zi",num) as String
            self.tableView.reloadData()
            
        }) { (err:Error?) in
            MBProgressHUD.hide(for: self.view)
        }

        
    
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
