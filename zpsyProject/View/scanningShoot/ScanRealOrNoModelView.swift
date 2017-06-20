//
//  ScanRealOrNoModel.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/28.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ScanRealOrNoModelView: NSObject {

    public var myType:scanProductType?
    public var circulateCount:NSInteger? = 3
    
    public var scanfinishmodel:scanFinishModel?{
    
        didSet{
        
            if let arr = scanfinishmodel?.goodsLotBatchArr{
                circulateCount = arr.count
            }
            
        }
    
    }
    
    public var CommentModelView : ScanCommentModelView?
    
    public func SC_numberOfSections(in tableView: UITableView) -> Int {
        return 3 + CommentModelView!.SC_numberOfSections(in: tableView)
    }
    
    public func SC_tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section==0 {
            return 1
        } else if section == 1 {
            if myType == scanProductType.ScanTypeFakeStamp || myType == scanProductType.ScanTypeQuality{
                return 0
            }
            
            var count = 0
            if let arr = self.scanfinishmodel?.scanrecordForSuspectProductArr {
                count = arr.count
            }
            return 1 + count
        } else if section == 2 {
            if myType == scanProductType.ScanTypeFakeStamp {
                return 0
            }
            return self.circulateCount! + 1
        } else{
        
            return CommentModelView!.SC_tableView(tableView, numberOfRowsInSection: section-3)
        
        }
    }
    
    
    public func SC_tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section==0{
            let cell:ScanStatusCell = tableView.dequeueReusableCell(withIdentifier: "ScanStatusCellIdentifier", for: indexPath) as! ScanStatusCell
            cell.productdetaiModel = self.scanfinishmodel?.proDetailModel
            cell.SnStr = self.scanfinishmodel?.codeSnId
            cell.resetData(statusType: myType!,NumStr: "正品溯源码：" + (self.scanfinishmodel?.codeSnId)!)
            return cell

        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "scanDeviceDisCellIdentifier")
                return cell!
            }
            else{
                let cell:ScanDeviceDataCell = tableView.dequeueReusableCell(withIdentifier: "ScanDeviceDataCellIdentifier")as! ScanDeviceDataCell
                cell.model = self.scanfinishmodel?.scanrecordForSuspectProductArr?[indexPath.row-1] as! ScanrecordForSuspectProductModel?
                return cell
            }
            
        }else if indexPath.section == 2{
        
            if indexPath.row == circulateCount {
                let cell = tableView.dequeueReusableCell(withIdentifier: "circulateScrowCellIdentifier", for: indexPath)
                return cell
            }
            
            let cell:CirculateInfoCell = tableView.dequeueReusableCell(withIdentifier: "CirculateInfoCellIdentifier", for: indexPath)as! CirculateInfoCell
            let model:GoodsLotBatchModel = self.scanfinishmodel?.goodsLotBatchArr![indexPath.row] as! GoodsLotBatchModel
            cell.setdata(timeStr: model.date!, detailstr: model.event!, indexrow:indexPath.row)
            return cell
            
            
        }else{
            
            return CommentModelView!.SC_tableView(tableView, cellForRowAt: IndexPath.init(row: indexPath.row, section: indexPath.section-3))
        }
    }
    
    public func SC_tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            if myType == scanProductType.ScanTypeFakeStamp {
                return 0
            }
            return UITableViewAutomaticDimension
        }else if section == 0 || section == 1 {
            return 0
        }
        return CommentModelView!.SC_tableView(tableView, heightForHeaderInSection: section-3)
    }
    
    public func SC_tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            if myType == scanProductType.ScanTypeFakeStamp {
                return nil
            }
            return piciheaderView()
        }else if section == 0 || section == 1 {
            return nil
        }
        else{
           return  CommentModelView?.SC_tableView(tableView, viewForHeaderInSection: section-3)
        }
    }
    
    public func SC_tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section==0 {
            return 10
        } else if section == 1 {
            if myType == scanProductType.ScanTypeFakeStamp || myType == scanProductType.ScanTypeQuality{
                return 0
            }
            return 10
        } else if section == 2 {
            if myType == scanProductType.ScanTypeFakeStamp {
                return 0
            }
            return 10
        }
        return CommentModelView!.SC_tableView(tableView, heightForFooterInSection: section-3)
    }
    public func SC_tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section < 3 {
            return nil
        } else {
            return CommentModelView?.SC_tableView(tableView, viewForFooterInSection: section)
        }
    }
    public func SC_tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.section < 3 {
            
        } else {
            CommentModelView?.SC_tableView(tableView, didSelectRowAt: IndexPath.init(row: indexPath.row, section: indexPath.section-3))
        }
    }
    
    private func piciheaderView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let img_1 = UIImageView.init(image: UIImage.init(named: "pici"))
        let img_2 = UIImageView.init(image: UIImage.init(named: "piciscrow"))
        view.addSubview(img_1)
        view.addSubview(img_2)
        
        img_1.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(view)
            let _ = make?.centerX.mas_equalTo()(view)
        }
        img_2.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(img_1.mas_bottom)?.offset()(15)
            let _ = make?.centerX.mas_equalTo()(view)
            let _ = make?.bottom.mas_equalTo()(view.mas_bottom)?.offset()(-15)
        }
        return view
    }
    
}
