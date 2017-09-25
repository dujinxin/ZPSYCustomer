//
//  FeedbackVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/15.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class FeedbackVC: UITableViewController {

    
    private var selectType:NSInteger?
    private var suggestStr:String?
    private var phoneNumStr:String?
    private lazy var PicSelect:KevenEditNewView={
        var picSelect = KevenEditNewView.init(frame: CGRect.init(x: 15, y: 0, width: kScreenWidth-30, height: 80), imagsUrl: nil, maxCount: 3, isEdit: true)
        picSelect?.addImageName="addpic"
        return picSelect!
    }()
    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.selectType = -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "意见反馈"
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        viewinit()
    }

    func viewinit() {
        
        self.tableView.register(feedbackselectCell.self, forCellReuseIdentifier: "feedbackselect")
        self.tableView.register(feedbackinfoCell.self, forCellReuseIdentifier: "feedbackinfo")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellidentifier")
        self.tableView.sectionHeaderHeight = 10
        self.tableView.sectionFooterHeight = 0.1
        
        
        let footerveiw=UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 115))
        self.tableView.tableFooterView=footerveiw
        
        let commitBtn = UIButton.init()
        commitBtn.setTitle("提交", for: UIControlState.normal)
        commitBtn.backgroundColor = JXMainColor
        commitBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        commitBtn.addTarget(self, action: #selector(self.commitbtnclickevent), for: UIControlEvents.touchUpInside)
        footerveiw.addSubview(commitBtn)
        
        commitBtn.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(footerveiw.mas_top)?.with().offset()(40)
            let _ = make?.left.mas_equalTo()(footerveiw.mas_left)?.with().offset()(60)
            let _ = make?.right.mas_equalTo()(footerveiw.mas_right)?.with().offset()(-60)
            let _ = make?.height.equalTo()(35)
        }
    }
    
    func commitbtnclickevent(){
        
        if self.selectType == -1 {
            MBProgressHUD.showError("请选择类型")
            return
        }
        if self.suggestStr == "" || self.suggestStr == nil{
            MBProgressHUD.showError("请写点什么吧")
            return
        }
        if self.phoneNumStr == "" || self.phoneNumStr == nil{
            MBProgressHUD.showError("请留下您的手机号吧")
            return
        }
        
        MBProgressHUD.showAnimationtoView(self.view)
        //提交请求
        if self.PicSelect.localImageArray.count == 0 {
          self.datarequest(["type":self.selectType!,"question":self.suggestStr!,"mobile":self.phoneNumStr ?? "","image":""])
            
        }else{
            UploadImageTool.uploadImages(self.PicSelect.localImageArray, progress: nil, success: { (result:[Any]?) in
                
                var imgStr = String()
                
                for item in result!{
                    imgStr.append(item as! String)
                    imgStr.append(",")
                }
                let length:NSInteger = imgStr.characters.count - 1
                let imgUrlStr = (imgStr as NSString).substring(to: length)
                
                self.datarequest(["type":self.selectType!,"question":self.suggestStr!,"mobile":self.phoneNumStr!,"image":imgUrlStr])
            }, failure: { 
                MBProgressHUD.hide(for: self.view)
            })
        }
    }
    
    private func datarequest(_ dict:NSDictionary) {
        
        BaseSeverHttp.zpsyPost(withPath: Api_submitFeedBack, withParams: dict, withSuccessBlock: {[weak self] (result:Any?) in
            MBProgressHUD.hide(for: self?.view)
           self?.successShow()
        }) { (err:Error?) in
            MBProgressHUD.hide(for: self.view)
        }
        
    }
    
    //提交成功界面显示
    private func successShow() {
        let corverView = UIView.init(frame: kScreenBounds)
        corverView.backgroundColor=UIColor.groupTableViewBackground
        
        let success=feedReportSuccessView.init(frame: CGRect.init(x: 0, y: 150*kScaleOfScreen, width: kScreenWidth, height: 151*kScaleOfScreen),showtype:0)
        
        corverView.addSubview(success)
        self.view.addSubview(corverView)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section==0 {
            return 1
        }
        return 2
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0 {
            return 88*kScaleOfScreen + 35
        }else{
            if indexPath.row==0 {
                return 227*kScaleOfScreen
            }
            return kScreenWidth/3-10
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section==0 {
            let cell : feedbackselectCell = tableView.dequeueReusableCell(withIdentifier: "feedbackselect") as! feedbackselectCell
            cell.titleName = "请您选择要反馈的问题"
            cell.selectresult = {(selecttype:NSInteger)->()in
                self.selectType=selecttype
            }
            return cell
        }else{
            
            if indexPath.row==0 {
            
                let cell:feedbackinfoCell = tableView.dequeueReusableCell(withIdentifier: "feedbackinfo") as! feedbackinfoCell
                cell.suggestresult = {(result:String)->Void in
                    self.suggestStr=result
                }
                cell.phoneresult = {(result:String)->Void in
                    self.phoneNumStr=result
                }
                return cell
            
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellidentifier")
                cell?.backgroundColor = UIColor.clear
                cell?.selectionStyle = UITableViewCellSelectionStyle.none
                cell?.contentView.addSubview(self.PicSelect)
                return cell!
            }
        }
    }

}
