//
//  ReportVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/17.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ReportVC: UITableViewController {

    public var SNString: String?
    public var PruductId:String?
    public var porductModel:productDetailModel?
    private var suggestStr:String?
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
        self.title="举报"
        self.tableView.separatorStyle=UITableViewCellSeparatorStyle.none
        self.tableView.estimatedRowHeight = 80.0
        viewinit()
    }
    
    private func viewinit() {
        
        self.tableView.register(ReportCell.self, forCellReuseIdentifier: "ReportCell")
        self.tableView.register(feedbackinfoCell.self, forCellReuseIdentifier: "feedbackinfo")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellidentifier")
        self.tableView.sectionHeaderHeight=10
        self.tableView.sectionFooterHeight=0.1
        
        let headerlab = UILabel.init(frame:CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 15))
//        headerlab.text="    请您选择要反馈的问题"
        self.tableView.tableHeaderView=headerlab
        
        
        let footerveiw=UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 75))
        self.tableView.tableFooterView=footerveiw
        
        let commitBtn = UIButton.init()
        commitBtn.setTitle("提交", for: UIControlState.normal)
        commitBtn.setTitleColor(kColor_red, for:
            UIControlState.normal)
        commitBtn.backgroundColor=kColor_red
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
    
    @objc private func commitbtnclickevent(){
//        successShow()
        if self.suggestStr=="" {
            MBProgressHUD.showError("请写点什么吧")
            return
        }
        if self.phoneNumStr=="" && !UserModel.shareInstance().isLogin{
            MBProgressHUD.showError("请留下您的手机号吧")
            return
        }
        
        //提交请求
        
        if self.PicSelect.localImageArray.count == 0 {
            
            self.datarequest(["sn":self.SNString ?? "","report_contents":self.suggestStr!,"mobile":self.phoneNumStr!,"image1":"","productid":self.PruductId ?? ""])
            
        }else{
            UploadImageTool.uploadImages(self.PicSelect.localImageArray, progress: nil, success: { (result:[Any]?) in
                
                var imgStr = String()
                
                for item in result!{
                    imgStr.append(item as! String)
                    imgStr.append(",")
                }
                let length:NSInteger = imgStr.characters.count - 1
                let imgUrlStr = (imgStr as NSString).substring(to: length)
                
                self.datarequest(["sn":self.SNString ?? "","report_contents":self.suggestStr!,"mobile":self.phoneNumStr!,"image1":imgUrlStr,"productid":self.PruductId ?? ""])
            }, failure: {
                MBProgressHUD.hide(for: self.view)
            })
        }
    }
    private func datarequest(_ dict:Any) {
        
        BaseSeverHttp.zpsyPost(withPath: Api_creatReport, withParams: dict, withSuccessBlock: {[weak self] (result:Any?) in
            MBProgressHUD.hide(for: self?.view)
            self?.successShow()
        }) { (err:Error?) in
            MBProgressHUD.hide(for: self.view)
        }
        
    }
    
    //提交成功界面显示
   private  func successShow() {
        
//        self.tableView.isScrollEnabled=false
//        
//        let cell = self.tableView.cellForRow(at: NSIndexPath.init(row: 0, section: 0) as IndexPath)
        
        let corverView = UIView.init(frame: kScreenBounds)
        corverView.backgroundColor=UIColor.groupTableViewBackground
        corverView.isUserInteractionEnabled=false
        
//        let rect:CGRect=(cell?.convert((cell?.frame)!, to: self.view))!
        
        let success=feedReportSuccessView.init(frame: CGRect.init(x: 0, y: 150*kScaleOfScreen, width: kScreenWidth, height: 151*kScaleOfScreen) ,showtype:1)
        
//        corverView.addSubview(cell!)
        corverView.addSubview(success)
        self.view.addSubview(corverView)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
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
            return UITableViewAutomaticDimension
        }else{
            if indexPath.row==0 {
                return 227*kScaleOfScreen
            }
            return kScreenWidth/3-10
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section==0 {
            let cell:ReportCell = tableView.dequeueReusableCell(withIdentifier: "ReportCell") as! ReportCell
            cell.ImageView.sd_setImage(with: URL.init(string: (self.porductModel?.getfirstGoodImg())!), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            cell.LogoImg.sd_setImage(with: URL.init(string: (self.porductModel?.thumbnail)!), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            cell.textlab.text = self.porductModel?.name
            cell.timerlab.text = CTUtility.string(from: self.porductModel?.createDateStr, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
            return cell
        }else{
            
            if indexPath.row==0 {
                
                let cell:feedbackinfoCell = tableView.dequeueReusableCell(withIdentifier: "feedbackinfo") as! feedbackinfoCell
                cell.suggestresult={(result:String)->Void in
                    self.suggestStr=result
                }
                cell.phoneresult={(result:String)->Void in
                    self.phoneNumStr=result
                }
                return cell
                
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellidentifier")
                cell?.backgroundColor=UIColor.clear
                cell?.selectionStyle=UITableViewCellSelectionStyle.none
                cell?.contentView.addSubview(self.PicSelect)
                return cell!
            }
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
