//
//  ScanRelativePriceModel.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/28.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ScanRelativePriceModelView: NSObject {

    
    private lazy var Arraylist:NSMutableArray = []
    private var isExpent = false
    
    public var CommentModelView : ScanCommentModelView?
    
    private var isfirstLoad:Bool = true
    
    public var keyWord:String? = ""
    
    private func datareloadRequest(tabl:UITableView){
        
        MBProgressHUD.showAnimationtoView(tabl)
        BaseSeverHttp.zpsyGet(withPath: Api_productComparePrices, withParams: ["keyword":(keyWord ?? "")], withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: tabl)
            
            self.Arraylist = priceModel.mj_objectArray(withKeyValuesArray: result)
            self.isfirstLoad = false
            tabl.reloadSections(IndexSet.init(integer: 1), with: UITableViewRowAnimation.bottom)
            
        }) { (err:Error?) in
            MBProgressHUD.hide(for: tabl)
        }
    }
    
    public func SC_numberOfSections(in tableView: UITableView) -> Int {
        
        if self.isfirstLoad {
            self.datareloadRequest(tabl: tableView)
        }
        
        return 1 + CommentModelView!.SC_numberOfSections(in: tableView)
    }
    
    public func SC_tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            
            if self.isfirstLoad {
                return 0
            }
            
            var listcount = self.Arraylist.count
            if isExpent == false {
                listcount = listcount>4 ? 4 : listcount
            }
            return listcount
        }
        else{
            return CommentModelView!.SC_tableView(tableView, numberOfRowsInSection: section-1);
        }
    }
    
    
    public func SC_tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "tableviewCellDetailId")
            if cell == nil {
                cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "tableviewCellDetailId")
                cell?.selectionStyle = UITableViewCellSelectionStyle.none
                cell?.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
                cell?.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
                cell?.detailTextLabel?.textColor=kColor_red
                cell?.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
            }
            
            let model:priceModel = self.Arraylist[indexPath.row] as! priceModel
            cell?.textLabel?.text = model.siteName
            cell?.detailTextLabel?.text="¥ " + model.spprice!
            return cell!
        }else{
            return CommentModelView!.SC_tableView(tableView, cellForRowAt: IndexPath.init(row: indexPath.row, section: indexPath.section-1))
        }
    }
    
    public func SC_tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return CommentModelView!.SC_tableView(tableView, heightForHeaderInSection: section-1)
    }
    
    public func SC_tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        return CommentModelView?.SC_tableView(tableView, viewForHeaderInSection: section-1)
    }
    
    public func SC_tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            if self.isfirstLoad {
                return 0
            }
            if self.isExpent == false && self.Arraylist.count>4{
                return 54.0
            }
            self.isExpent = true
            return 10
        }
        return CommentModelView!.SC_tableView(tableView, heightForFooterInSection: section-1)
    }
    public func SC_tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 && isExpent == false {
            if self.isfirstLoad {
                return nil
            }
            let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 44))
            btn.backgroundColor=UIColor.white
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.setTitle("更多", for: UIControlState.normal)
            btn.rac_signal(for: UIControlEvents.touchUpInside).subscribeNext({[weak self] (x:Any?) in
                self?.isExpent=true
                tableView.reloadSections(NSIndexSet.init(index: section+1) as IndexSet, with: UITableViewRowAnimation.bottom)
            })
            let view=UIView.init(frame: CGRect.init(x: 0, y: 43, width: kScreenWidth, height: 54))
            view.backgroundColor=UIColor.groupTableViewBackground
            view.addSubview(btn)
            let lineview=UIView.init(frame: CGRect.init(x: 10, y: 0, width: kScreenWidth-30, height: 1))
            lineview.backgroundColor=UIColor.groupTableViewBackground
            lineview.layer.zPosition=100
            view.addSubview(lineview)
            return view
        }
        return CommentModelView?.SC_tableView(tableView, viewForFooterInSection: section-1)
    }
    
    public func SC_tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.section == 0 {
            let webVC=WKwebVC()
            let model:priceModel = self.Arraylist[indexPath.row] as! priceModel
            webVC.urLstr=model.spurl
            CTUtility.findViewController(tableView).navigationController?.pushViewController(webVC, animated: true)
        }
        else {
            CommentModelView?.SC_tableView(tableView, didSelectRowAt: IndexPath.init(row: indexPath.row, section: indexPath.section-1))
        }
    }

    
    
    
    
}
