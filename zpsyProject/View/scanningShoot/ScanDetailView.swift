//
//  ScanDetailView.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/28.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit


class ScanDetailView: UITableView, UITableViewDelegate,UITableViewDataSource{
    
    public var scanfinishmodel:scanFinishModel? {
    
        didSet{
        
            self.realOrNoModelView.scanfinishmodel = self.scanfinishmodel
            self.CommentModelView.scanfinishmodel = self.scanfinishmodel
            self.relativePriceModelView.keyWord = scanfinishmodel?.proDetailModel?.name
            if scanfinishmodel?.quality == "0" {
                myProductType = scanProductType.ScanTypeQuality
            }else if scanfinishmodel?.quality == "1" {
                myProductType = scanProductType.ScanTypeSuspicious
            }else{
                myProductType = scanProductType.ScanTypeFakeStamp
            }
            self.reloadData()
        }
        
    }
    
    private var myProductType:scanProductType? = scanProductType.ScanTypeSuspicious
    
    private lazy var realOrNoModelView:ScanRealOrNoModelView={
        let realOrNot = ScanRealOrNoModelView()
        return realOrNot
    }()
    private lazy var relativePriceModelView:ScanRelativePriceModelView={
        let realOrNot = ScanRelativePriceModelView()
        return realOrNot
    }()
    
    private lazy var CommentModelView = ScanCommentModelView()
    
    public var selectedSegmentIndex:NSInteger = 0{
        didSet{
            self.CommentModelView.myselectType = selectedSegmentIndex
            self.reloadData()
        }
    
    }
    
    public var scrollDIdScrollBlock : ((_ Y:CGFloat)->Void)?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 10;
        self.estimatedSectionHeaderHeight = 44;
        viewInit()
    }
    
    private func viewInit(){
        
        //self.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 49))
        
        CommentModelView.MyTableView = self
        self.realOrNoModelView.myType=self.myProductType
        self.realOrNoModelView.CommentModelView = CommentModelView
        
        self.relativePriceModelView.CommentModelView = CommentModelView
        
        
        self.register(scanProductCell.self, forCellReuseIdentifier: "scanProductCellId")
        self.register(scanProdStandardCell.self, forCellReuseIdentifier: "scanProdStandardCellId")
        self.register(UITableViewCell.self, forCellReuseIdentifier: "tableviewCellDefaultId")
        self.register(HotRemarkCell.self, forCellReuseIdentifier: "RemarkCellID")
        self.register(ScanStatusCell.self, forCellReuseIdentifier: "ScanStatusCellIdentifier")
        self.register(ScanDeviceDisCell.self, forCellReuseIdentifier: "scanDeviceDisCellIdentifier")
        self.register(ScanDeviceDataCell.self, forCellReuseIdentifier: "ScanDeviceDataCellIdentifier")
        self.register(CirculateInfoCell.self, forCellReuseIdentifier: "CirculateInfoCellIdentifier")
        self.register(circulateScrowCell.self, forCellReuseIdentifier: "circulateScrowCellIdentifier")
        self.register(scanlikeCell.self, forCellReuseIdentifier: "scanlikeCellIdentifier")
        
    }
    
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.selectedSegmentIndex==0 {
            return realOrNoModelView.SC_numberOfSections(in: tableView) + 1
        }
        else{
            return relativePriceModelView.SC_numberOfSections(in: tableView) + 1
        }
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 2;
        }else{
            if self.selectedSegmentIndex == 0 {
                return realOrNoModelView.SC_tableView(tableView, numberOfRowsInSection: section-1)
            }else{
                return relativePriceModelView.SC_tableView(tableView, numberOfRowsInSection: section-1)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section==0 {
            if indexPath.row == 0 {
                let productCell:scanProductCell=tableView.dequeueReusableCell(withIdentifier: "scanProductCellId")as! scanProductCell
                productCell.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15)
                productCell.model = scanfinishmodel?.proDetailModel
                return productCell
            }else{
                let cell:scanProdStandardCell=tableView.dequeueReusableCell(withIdentifier: "scanProdStandardCellId")as! scanProdStandardCell
                cell.model = scanfinishmodel?.proDetailModel
                return cell
            }
        }
        else{
            let newIndexPath = NSIndexPath.init(row: indexPath.row, section: indexPath.section-1)
            if self.selectedSegmentIndex == 0 {
                return realOrNoModelView.SC_tableView(tableView, cellForRowAt: newIndexPath as IndexPath)
            }else{
                return relativePriceModelView.SC_tableView(tableView, cellForRowAt: newIndexPath as IndexPath)
            }
        }
     }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }else{
            if self.selectedSegmentIndex == 0 {
                return realOrNoModelView.SC_tableView(tableView, heightForHeaderInSection: section-1)
            }else{
                return relativePriceModelView.SC_tableView(tableView, heightForHeaderInSection: section-1)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }else{
            if self.selectedSegmentIndex == 0 {
                return realOrNoModelView.SC_tableView(tableView, viewForHeaderInSection: section-1)
            }else{
                return relativePriceModelView.SC_tableView(tableView, viewForHeaderInSection: section-1)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }else{
            if self.selectedSegmentIndex == 0 {
                return realOrNoModelView.SC_tableView(tableView, heightForFooterInSection: section-1)
            }else{
                return relativePriceModelView.SC_tableView(tableView, heightForFooterInSection: section-1)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }else{
            if self.selectedSegmentIndex == 0 {
                return realOrNoModelView.SC_tableView(tableView, viewForFooterInSection: section-1)
            }else{
                return relativePriceModelView.SC_tableView(tableView, viewForFooterInSection: section-1)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if indexPath.row == 0 {
                let productVc = ProductDetailVC()
                productVc.hidesBottomBarWhenPushed=true
                productVc.ProductID = scanfinishmodel?.proDetailModel?.ID
                CTUtility.findViewController(self).navigationController?.pushViewController(productVc, animated: true)
            }
        }
        else{
            let newIndexPath = NSIndexPath.init(row: indexPath.row, section: indexPath.section-1)
            if self.selectedSegmentIndex==0 {
                self.realOrNoModelView.SC_tableView(tableView, didSelectRowAt: newIndexPath as IndexPath)
            }else{
                self.relativePriceModelView.SC_tableView(tableView, didSelectRowAt: newIndexPath as IndexPath)
            }
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let Y = scrollView.contentOffset.y
        let data_Y = self.contentSize.height - self.frame.size.height
        if Y >= data_Y || Y <= -64{
            return
        }
        if self.scrollDIdScrollBlock != nil {
            self.scrollDIdScrollBlock!(Y+64)
        }
    }

}
