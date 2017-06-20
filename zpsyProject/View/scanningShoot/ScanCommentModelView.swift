//
//  ScanCommentModelView.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/17.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ScanCommentModelView: NSObject {
    
    public var scanfinishmodel:scanFinishModel? {
    
        didSet{

            
            let dict = ["pageNo":"1","id":scanfinishmodel?.proDetailModel?.ID ?? "","type":commentType.commentProduct.rawValue ,"isforHotFive":true] as [String : Any]
            MBProgressHUD.showAnimationtoView(self.MyTableView)
            BaseSeverHttp.zpsyGet(withPath: Api_commentGetComment, withParams: dict, withSuccessBlock: { (result:Any?) in
                MBProgressHUD.hide(for: self.MyTableView)
                let resultDict:NSDictionary = result as! NSDictionary
                self.remarkNum = (resultDict["sum"] as! NSNumber).stringValue
                let arr:NSArray = hotremarkModel.mj_objectArray(withKeyValuesArray: resultDict["list_comment"])
                self.commendList = arr
                self.MyTableView?.reloadSections(IndexSet.init(integer: (self.MyTableView?.numberOfSections)!-1), with: UITableViewRowAnimation.bottom)
            }) { (err:Error?) in
                MBProgressHUD.hide(for: self.MyTableView)
            }
            
        }
    
    }
    public var myselectType:NSInteger = 0 //0:识真假 ； 1：比价格
    public var remarkNum:String? = "0"
    
    weak public var MyTableView:UITableView?
    
    public func SC_numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    private var commendList:NSArray? = []
    
    public func SC_tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if myselectType == 0 {
            if section == 1 {
                return commendList!.count + 1
            }
            return 1
        }else{
            if section == 1 {
                return commendList!.count + 1
            }
            return 0
        }
        
    }
    
    public func SC_tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell:scanlikeCell = tableView.dequeueReusableCell(withIdentifier: "scanlikeCellIdentifier", for: indexPath)as! scanlikeCell
            cell.produModel = self.scanfinishmodel?.proDetailModel
            cell.userPraiseArr = self.scanfinishmodel?.userPraiseArr
            return cell
        }
        if indexPath.section == 1 && indexPath.row == commendList?.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewCellDefaultId")
            cell?.textLabel?.text = "查看全部评论"
            cell?.textLabel?.textColor = UIColor.gray
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell?.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            return cell!
        }
        
        let cell:HotRemarkCell = tableView.dequeueReusableCell(withIdentifier: "RemarkCellID", for: indexPath)as! HotRemarkCell
        let model:hotremarkModel = self.commendList![indexPath.row] as! hotremarkModel
        cell.MyImageView.sd_setImage(with: URL.init(string: model.avatar ?? ""), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
        cell.myTitleLab.text = model.nickName
        cell.myLikeLab.text = model.praiseNum
        cell.myDetLab.text = model.content
        cell.myTimeLab.text = CTUtility.string(from: model.createDateStr, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy年MM月dd日 HH:mm")
        cell.praiseClickBlock = {[weak self]()->Void in
            self?.praiseclickEvent(indexPath.row)
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        return cell
    }
    
    private func praiseclickEvent(_ row :NSInteger) -> Void {
        
            let model:hotremarkModel = self.commendList![row] as! hotremarkModel
            let dict = ["id":model.ID,"type":"0"]
        MBProgressHUD.showAnimationtoView(self.MyTableView)
        BaseSeverHttp.zpsyGet(withPath: Api_praiseCommitPraise, withParams: dict, withSuccessBlock: { (result:Any?) in
                MBProgressHUD.hide(for: self.MyTableView)
                
                var num:NSInteger = NSInteger.init(model.praiseNum!)!
                num+=1
                model.praiseNum = NSString.init(format: "%zi",num) as String
                self.MyTableView?.reloadSections(IndexSet.init(integer: (self.MyTableView?.numberOfSections)!-1), with: UITableViewRowAnimation.bottom)
                
            }) { (err:Error?) in
                MBProgressHUD.hide(for: self.MyTableView)
            }
            
            
            
    }

        
    public func SC_tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 44
        }
        return 0
    }
    
    public func SC_tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let remarkLab = UILabel.init(frame: CGRect.init(x: 0, y: 15, width: kScreenWidth, height: 44))
            remarkLab.text = "    评论(" + self.remarkNum! + ")"
            remarkLab.backgroundColor=UIColor.white
            remarkLab.textColor=UIColor.black
            let view = UIView.init(frame: CGRect.init(x: 0, y: 43, width: kScreenWidth, height: 1))
            view.backgroundColor=UIColor.groupTableViewBackground
            view.layer.zPosition=100
            remarkLab.addSubview(view)
            return remarkLab;
        }
        return nil
    }
    
    public func SC_tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if myselectType == 0 {
            if section == 0 {
                return 10
            }
        }
        return 0
    }
    public func SC_tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    public func SC_tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.section == 1 && indexPath.row == commendList?.count {
            let remarkvc = HotRemarkVC();
            remarkvc.resourcesId = self.scanfinishmodel?.proDetailModel?.ID
            remarkvc.mycommenttype = commentType.commentProduct
            remarkvc.hidesBottomBarWhenPushed = true
            CTUtility.findViewController(tableView).navigationController?.pushViewController(remarkvc, animated: true)
        }
    }

}
