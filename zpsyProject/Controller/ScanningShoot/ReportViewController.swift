//
//  ReportViewController.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/8/29.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ReportViewController: UITableViewController {
    
    public var SNString: String?
    public var countryType : String?
    public var PruductId:String?
    public var porductModel:productDetailModel?
    
    private var selectType : NSInteger = -1
    private var suggestStr:String?
    private var nameStr:String?
    private var phoneNumStr:String?
    
    private lazy var PicSelect:KevenEditNewView={
        var picSelect = KevenEditNewView.init(frame: CGRect.init(x: 15, y: 0, width: kScreenWidth-30, height: 80), imagsUrl: nil, maxCount: 3, isEdit: true)
        picSelect?.addImageName="addpic"
        return picSelect!
    }()
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "疑似伪品举报"
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.estimatedRowHeight = 80.0
        
        viewinit()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    private func viewinit() {
        
        self.tableView.register(ReportViewCell.self, forCellReuseIdentifier: "ReportViewCell")
        self.tableView.register(feedbackselectCell.self, forCellReuseIdentifier: "feedbackselect")
        self.tableView.register(FeedBackViewCell.self, forCellReuseIdentifier: "FeedBackViewCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellidentifier")
        self.tableView.sectionHeaderHeight = 10
        self.tableView.sectionFooterHeight = 0.1
        
        
        let footerveiw = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 160))
        self.tableView.tableFooterView = footerveiw
        
        let commitButton = UIButton.init()
        commitButton.setTitle("提交", for: UIControlState.normal)
        commitButton.backgroundColor = JXMainColor
        commitButton.layer.cornerRadius = 5
        commitButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        commitButton.addTarget(self, action: #selector(commitEvents), for: UIControlEvents.touchUpInside)
        footerveiw.addSubview(commitButton)
        
        commitButton.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(footerveiw.mas_top)?.with().offset()(40)
            let _ = make?.left.mas_equalTo()(footerveiw.mas_left)?.with().offset()(60)
            let _ = make?.right.mas_equalTo()(footerveiw.mas_right)?.with().offset()(-60)
            let _ = make?.height.equalTo()(35)
        }
        
        let cancelButton = UIButton.init()
        cancelButton.setTitle("取消", for: UIControlState.normal)
        cancelButton.backgroundColor = UIColor.rgbColor(rgbValue: 0xd2d2d2)
        cancelButton.layer.cornerRadius = 5
        cancelButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        cancelButton.addTarget(self, action: #selector(cancelEvents), for: UIControlEvents.touchUpInside)
        footerveiw.addSubview(cancelButton)
        
        cancelButton.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(commitButton.mas_bottom)?.with().offset()(10)
            let _ = make?.left.mas_equalTo()(footerveiw.mas_left)?.with().offset()(60)
            let _ = make?.right.mas_equalTo()(footerveiw.mas_right)?.with().offset()(-60)
            let _ = make?.height.equalTo()(35)
        }
        
    }
    func cancelEvents() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func commitEvents(){
        //        successShow()
        if !UserManager.manager.isLogin {
            let login = LoginVC.init()
            login.hidesBottomBarWhenPushed =  true
            self.navigationController?.pushViewController(login, animated: false)
            return
        }
        if selectType == -1{
            MBProgressHUD.showError("请选择举报原因")
            return
        }
        guard
            let suggestString = self.suggestStr,
            suggestString.isEmpty == false else {
                MBProgressHUD.showError("请写点什么吧")
                return
        }
        guard
            let nameStr = self.nameStr,
            nameStr.isEmpty == false
            else {
                MBProgressHUD.showError("请留下您的姓名吧")
                return
        }
        guard
            let phoneNumString = self.phoneNumStr,
            phoneNumString.isEmpty == false
            else {
                MBProgressHUD.showError("请留下您的手机号吧")
                return
        }
        if String.validateTelephone(tel: phoneNumString) == false {
            MBProgressHUD.showError("手机号格式不正确")
            return
        }
        
        //提交请求
        if self.PicSelect.localImageArray.count == 0 {
            
            self.datarequest(["sn":self.SNString ?? "","countryType":self.countryType ?? "","report_contents":suggestString,"mobile":phoneNumString,"image1":"","productid":self.PruductId ?? "","cause":selectType,"name":nameStr])
            
        }else{
            UploadImageTool.uploadImages(self.PicSelect.localImageArray, progress: nil, success: { (result:[Any]?) in
                
                var imgStr = String()
                
                for item in result!{
                    imgStr.append(item as! String)
                    imgStr.append(",")
                }
                let length:NSInteger = imgStr.characters.count - 1
                let imgUrlStr = (imgStr as NSString).substring(to: length)
                
                self.datarequest(["sn":self.SNString ?? "","countryType":self.countryType ?? "","report_contents":suggestString,"mobile":phoneNumString,"image1":imgUrlStr,"productid":self.PruductId ?? "","cause":self.selectType,"name":nameStr])
            }, failure: {
                MBProgressHUD.hide(for: self.view)
            })
        }
    }
    private func datarequest(_ dict:Any) {
        self.view.endEditing(true)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        BaseSeverHttp.zpsyPost(withPath: Api_creatReport, withParams: dict, withSuccessBlock: {[weak self] (result:Any?) in
            MBProgressHUD.hide(for: self?.view)
            self?.successShow()
        }) { (err:Error?) in
            MBProgressHUD.hide(for: self.view)
        }
    }
    
    //提交成功界面显示
    private  func successShow() {
        
        self.tableView.contentOffset = CGPoint(x: 0, y: 0)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.isScrollEnabled = false
        
        
        let corverView = UIView.init(frame: kScreenBounds)
        corverView.backgroundColor = UIColor.groupTableViewBackground
        corverView.isUserInteractionEnabled = false

        let success = feedReportSuccessView.init(frame: CGRect.init(x: 0, y: 150*kScaleOfScreen, width: kScreenWidth, height: 151*kScaleOfScreen) ,showtype:1)

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
        if section == 0 {
            return 2
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return UITableViewAutomaticDimension
            }
            return 88*kScaleOfScreen + 35
        }else{
            if indexPath.row == 0 {
                return 269*kScaleOfScreen
            }
            return kScreenWidth/3-10
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell : ReportViewCell = tableView.dequeueReusableCell(withIdentifier: "ReportViewCell") as! ReportViewCell
                cell.goodsImageView.sd_setImage(with: URL.init(string: (self.porductModel?.getfirstGoodImg())!), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
                //cell.LogoImg.sd_setImage(with: URL.init(string: (self.porductModel?.thumbnail)!), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
                cell.productLabel.text = self.porductModel?.name
                cell.timeLabel.text = CTUtility.string(from: self.porductModel?.createDateStr, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
                cell.codeLabel.text = String.init(format: "正品标签明码:%@", self.porductModel?.code ?? "")
                
                return cell
            }else{
                let cell:feedbackselectCell = tableView.dequeueReusableCell(withIdentifier: "feedbackselect") as! feedbackselectCell
                cell.titleName = "举报原因"
                cell.titleArray = ["感觉是假的","标签印刷粗糙","渠道有问题","其他"]
                cell.selectresult={(selecttype:NSInteger)->()in
                    self.selectType=selecttype
                }
                return cell
            }
            
        }else{
                
            if indexPath.row == 0 {
                
                let cell:FeedBackViewCell = tableView.dequeueReusableCell(withIdentifier: "FeedBackViewCell") as! FeedBackViewCell
                cell.contentPlaceholderString = "请您填写疑似伪品的原因，经我方确认您举报的商品是伪品，我们会抽取幸运者为您送上一份礼物"
                cell.suggestBlock = {(result:String)->Void in
                    self.suggestStr = result
                }
                cell.nameBlock = {(result:String)->Void in
                    self.nameStr = result
                }
                cell.phoneBlock = {(result:String)->Void in
                    self.phoneNumStr = result
                }
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellidentifier")
                cell?.backgroundColor = UIColor.clear
                cell?.selectionStyle = UITableViewCellSelectionStyle.none
                cell?.contentView.addSubview(self.PicSelect)
                return cell!
            }
        }
    }

//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        self.view.endEditing(true)
//    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
}
