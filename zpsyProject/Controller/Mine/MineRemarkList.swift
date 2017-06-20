//
//  MineRemarkList.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/22.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class MineRemarkList: UITableViewController {
    
    private struct modelStruct {
        var page:NSInteger = 1
        var ListArray:NSMutableArray? = NSMutableArray.init()
    }
    
    private var productModelStruct:modelStruct = modelStruct()
    private var exposureModelStruct:modelStruct = modelStruct()
    private var PrefomersModelStruct:modelStruct = modelStruct()
    
    private var selectIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="评论"
        viewinit()
    }

    private func viewinit() {
        let segment = ProductOrExposureSelectView.init()
        self.tableView.tableHeaderView=segment
        segment.valueDidChangeWithIndexBlock={[weak self] (index:NSInteger) ->Void in
            self?.selectIndex=index;
            if self?.selectIndex==1 && self?.exposureModelStruct.ListArray?.count == 0 {
                self?.daterequest()
            }else if self?.selectIndex==0 && self?.productModelStruct.ListArray?.count == 0 {
                self?.daterequest()
            }else if self?.selectIndex==2 && self?.PrefomersModelStruct.ListArray?.count == 0{
                self?.daterequest()
            }
            self?.tableView.reloadData()
        }
        
        self.tableView.rowHeight=UITableViewAutomaticDimension
        self.tableView.sectionFooterHeight=1
        self.tableView.sectionHeaderHeight=14
        self.tableView.estimatedRowHeight=5
    
        
        self.tableView.register(ReportCell.self, forCellReuseIdentifier: "productCellId")
        self.tableView.register(CollectionExposureCell.self, forCellReuseIdentifier: "CollectionExposureCellID")
        self.tableView.register(HotRemarkCell.self, forCellReuseIdentifier: "RemarkCellID")
        
        daterequest()
        
    }
    
    
    private func daterequest() {
        MBProgressHUD.showAnimationtoView(self.view)
        if self.selectIndex == 1 {
            
            BaseSeverHttp.zpsyGet(withPath: Api_GetMyExposureBarComment, withParams: ["pageNo":self.exposureModelStruct.page], withSuccessBlock: {[unowned self] (result:Any?) in
                MBProgressHUD.hide(for: self.view)
                let arr:Array = myCommentExpModel.mj_objectArray(withKeyValuesArray: result) as Array
                if self.exposureModelStruct.page == 1{
                    self.exposureModelStruct.ListArray = NSMutableArray.init(array: arr)
                }
                else{
                    self.exposureModelStruct.ListArray?.addObjects(from: arr)
                }
                self.tableView.reloadData()
                
                }, withFailurBlock: { (error:Error?) in
                    MBProgressHUD.hide(for: self.view)
            })
            
        }else if self.selectIndex == 2 {
            
            BaseSeverHttp.zpsyGet(withPath: Api_GetMyPreferenceComment, withParams: ["pageNo":self.PrefomersModelStruct.page], withSuccessBlock: {[unowned self] (result:Any?) in
                MBProgressHUD.hide(for: self.view)
                
                let arr:Array = myCommentExpModel.mj_objectArray(withKeyValuesArray: result) as Array
                
                if self.PrefomersModelStruct.page == 1{
                    self.PrefomersModelStruct.ListArray = NSMutableArray.init(array: arr)
                }
                else{
                    self.PrefomersModelStruct.ListArray?.addObjects(from: arr)
                }
                self.tableView.reloadData()
                
                }, withFailurBlock: { (error:Error?) in
                    MBProgressHUD.hide(for: self.view)
            })
            
        }
        else{
            
            BaseSeverHttp.zpsyGet(withPath: Api_GetMyGoodsComment, withParams: ["pageNo":self.productModelStruct.page], withSuccessBlock: {[unowned self] (result:Any?) in
                MBProgressHUD.hide(for: self.view)
                let arr:Array = myCommentProModel.mj_objectArray(withKeyValuesArray: result) as Array

                if self.productModelStruct.page == 1{
                    self.productModelStruct.ListArray = NSMutableArray.init(array: arr)
                }
                else{
                    self.productModelStruct.ListArray?.addObjects(from: arr)
                }
                self.tableView.reloadData()
                }, withFailurBlock: { (error:Error?) in
                    MBProgressHUD.hide(for: self.view)
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.selectIndex == 0 {
            return (self.productModelStruct.ListArray?.count)!
        }else if self.selectIndex == 1{
            return (self.exposureModelStruct.ListArray?.count)!
        }else{
            return (self.PrefomersModelStruct.ListArray?.count)!
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row==0 {
            if self.selectIndex==0 {
                let cell:ReportCell = tableView.dequeueReusableCell(withIdentifier: "productCellId", for: indexPath)as! ReportCell
                let model:myCommentProModel = self.productModelStruct.ListArray![indexPath.section] as! myCommentProModel
                cell.textlab.text = model.proModel?.name as String?
                if let promodel = model.proModel{
                
                    cell.ImageView.sd_setImage(with: URL.init(string: (promodel.getfirstGoodImg()) as String), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
                    cell.LogoImg.sd_setImage(with: URL.init(string: promodel.thumbnail! as String), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
                    cell.timerlab.text = CTUtility.string(from: promodel.createDateStr as String!, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
                }
                return cell
            }else{
                let cell:CollectionExposureCell = tableView.dequeueReusableCell(withIdentifier: "CollectionExposureCellID", for: indexPath)as! CollectionExposureCell
                if self.selectIndex == 1{
                    let model:myCommentExpModel = self.exposureModelStruct.ListArray![indexPath.section] as! myCommentExpModel
                    model.expModel?.ID = model.resourcesId
                    cell.model = model.expModel
                }else if self.selectIndex == 2{
                    let model:myCommentExpModel = self.PrefomersModelStruct.ListArray![indexPath.section] as! myCommentExpModel
                    model.preferenceModel?.ID = model.resourcesId
                    cell.model = model.preferenceModel
                }
                
                return cell
            }
        }else{
        
            let cell:HotRemarkCell = tableView.dequeueReusableCell(withIdentifier: "RemarkCellID", for: indexPath)as! HotRemarkCell
            
            var contentStr = ""
            var timerStr = ""
            var likeStr = ""
            if self.selectIndex == 0 {
                let model:myCommentProModel = self.productModelStruct.ListArray![indexPath.section] as! myCommentProModel
                contentStr = model.content!
                timerStr = model.createDateStr!
                likeStr = model.praiseNum!
            }else{
                if self.selectIndex == 1{
                    let model:myCommentExpModel = self.exposureModelStruct.ListArray![indexPath.section] as! myCommentExpModel
                    contentStr = model.content!
                    timerStr = model.createDateStr!
                    likeStr = model.praiseNum!
                }else if self.selectIndex == 2{
                    let model:myCommentExpModel = self.PrefomersModelStruct.ListArray![indexPath.section] as! myCommentExpModel
                    contentStr = model.content!
                    timerStr = model.createDateStr!
                    likeStr = model.praiseNum!
                }
            }
            
            cell.MyImageView.sd_setImage(with: URL.init(string: UserModel.shareInstance().userInfo.avatar), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            cell.myTitleLab.text = UserModel.shareInstance().userInfo.nickName
            cell.myLikeLab.text = likeStr
            cell.myDetLab.text = contentStr
            cell.myTimeLab.text = CTUtility.string(from: timerStr, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy年MM月dd日 HH:mm")
            cell.praiseClickBlock = {[weak self]()->Void in
                self?.praiseclickEvent(indexPath.section)
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
         
            if self.selectIndex == 0{
                
                let model:myCommentProModel = self.productModelStruct.ListArray?.object(at: indexPath.section) as! myCommentProModel
                let detailVC:ProductDetailVC = ProductDetailVC()
                detailVC.ProductID = model.proModel?.ID as String?
                self.navigationController?.pushViewController(detailVC, animated: true)
                
            }else{
                let expoDetailVC = ExposureDetailVC()
                if self.selectIndex == 2{
                    let model:myCommentExpModel = self.PrefomersModelStruct.ListArray?.object(at: indexPath.section) as! myCommentExpModel
                    expoDetailVC.urlStr = model.preferenceModel?.jumpUrl
                    expoDetailVC.thatID = model.resourcesId
                    expoDetailVC.webtype = model.preferenceModel?.field3
                    expoDetailVC.detilStr = model.preferenceModel?.detail
                }else{
                    let model:myCommentExpModel = self.exposureModelStruct.ListArray?.object(at: indexPath.section) as! myCommentExpModel
                    expoDetailVC.urlStr = model.expModel?.jumpUrl
                    expoDetailVC.thatID = model.resourcesId
                    expoDetailVC.webtype = model.expModel?.field3
                    expoDetailVC.detilStr = model.expModel?.detail
                }
                
                self.navigationController?.pushViewController(expoDetailVC, animated: true)
            }

            
        }
    }
    
    
    private func praiseclickEvent(_ row :NSInteger) -> Void {
        var ID = ""
        var Type = ""
        if self.selectIndex == 0 {
            let model:myCommentProModel = self.productModelStruct.ListArray![row] as! myCommentProModel
            ID = model.ID!
            Type = "1"
        }else if self.selectIndex == 1{
            let model:myCommentExpModel = self.exposureModelStruct.ListArray![row] as! myCommentExpModel
            ID = model.ID!
            Type = "3"
        }else{
            let model:myCommentExpModel = self.PrefomersModelStruct.ListArray![row] as! myCommentExpModel
            ID = model.ID!
            Type = "5"
        }
        let dict = ["id":ID,"type":Type]
        MBProgressHUD.showAnimationtoView(self.view)
        BaseSeverHttp.zpsyGet(withPath: Api_praiseCommitPraise, withParams: dict, withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: self.view)
            
            if self.selectIndex == 0 {
                let model:myCommentProModel = self.productModelStruct.ListArray![row] as! myCommentProModel
                var num:NSInteger = NSInteger.init(model.praiseNum!)!
                num+=1
                model.praiseNum = NSString.init(format: "%zi",num) as String
            }else if self.selectIndex == 1 {
                let model:myCommentExpModel = self.exposureModelStruct.ListArray![row] as! myCommentExpModel
                var num:NSInteger = NSInteger.init(model.praiseNum!)!
                num+=1
                model.praiseNum = NSString.init(format: "%zi",num) as String
            }else{
                let model:myCommentExpModel = self.exposureModelStruct.ListArray![row] as! myCommentExpModel
                var num:NSInteger = NSInteger.init(model.praiseNum!)!
                num+=1
                model.praiseNum = NSString.init(format: "%zi",num) as String
            }
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
