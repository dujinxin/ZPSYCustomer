//
//  NewScanDetailVc.swift
//  ZPSY
//
//  Created by zhouhao on 2017/4/8.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class NewScanDetailVc: UITableViewController {
    public var scanfinishmodel:scanFinishModel? {
        
        didSet{
            
            if scanfinishmodel?.quality == "0" {
                myProductType = scanProductType.ScanTypeQuality
            }else if scanfinishmodel?.quality == "1"{
                myProductType = scanProductType.ScanTypeSuspicious
            }else{
                myProductType = scanProductType.ScanTypeFakeStamp
            }
            self.tableView.reloadData()
        }
    }
    
    private var myProductType:scanProductType? = scanProductType.ScanTypeFakeStamp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "正品溯源"
        viewinit()
        
//        zpSelectView.isUserInteractionEnabled = true
//        zpSelectView.setCustomView(view: addCustomSubViews())
        
        //zpCustomView = addCustomSubViews()
        
        //zpSelectView.setCustomView(view: zpCustomView)
        
    }
    
    private func viewinit() {
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.separatorColor = UIColor.init(white: 0.8, alpha: 0.5)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 10
        self.tableView.estimatedSectionHeaderHeight = 44
        
        self.tableView.register(ScanStatusCell.self, forCellReuseIdentifier: "ScanStatusCellIdentifier")
        
        self.tableView.register(newScanProductCell.self, forCellReuseIdentifier: "newScanProductCellId")
        
        self.tableView.register(productDetailCell.self, forCellReuseIdentifier: "productDetailCellId")
        self.tableView.register(productDetaiImageCell.self, forCellReuseIdentifier: "productDetaiImageCellId")
        
        self.tableView.register(companyDetailCell.self, forCellReuseIdentifier: "companyDetailCellId")
        
        self.tableView.register(ScanDeviceDataCell.self, forCellReuseIdentifier: "ScanDeviceDataCellId")
        self.tableView.register(scanLogisticsCell.self, forCellReuseIdentifier: "scanLogisticsCellId")
        self.tableView.register(ScanDeviceDisCell.self, forCellReuseIdentifier: "scanDeviceDisCellIdentifier")
        
        self.tableView.register(scanProductHeader.self, forHeaderFooterViewReuseIdentifier: "scanProductHeaderID")
        self.priceView.keyName = self.scanfinishmodel?.proDetailModel?.name
        
        
    }

    
    private var isExpendOfSectionTwo:Bool? = false
    private var isExpendOfSectionThree:Bool? = false
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.myProductType == scanProductType.ScanTypeFakeStamp {
            return 3
        }
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var Mycount = 0
        
        if section == 0 || section == 1 || section == 3{
            return 1
        }else if section == 2{
            if !self.isExpendOfSectionTwo! {
                Mycount = (self.scanfinishmodel?.proDetailModel?.list_ceccGoodsField?.count)! + 1
            }
            return  Mycount

//            Mycount = (self.scanfinishmodel!.scanrecordForSuspectProductArr?.count)!
//            if !self.isExpendOfSectionTwo! {
//                Mycount = Mycount > 3 ? 3 : Mycount
//            }
//            return  Mycount + 1
        }
        
        Mycount = (self.scanfinishmodel!.goodsLotBatchArr?.count)!
        if !self.isExpendOfSectionThree! {
            Mycount = Mycount > 3 ? 3 : Mycount
        }
        return  Mycount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {//商品信息
            let cell:newScanProductCell = tableView.dequeueReusableCell(withIdentifier: "newScanProductCellId", for: indexPath) as! newScanProductCell
            cell.comparePriceBlock = {[weak self]()->Void in
                self?.priceCompare()
            }
            cell.goodsImage.sd_setImage(with: URL.init(string: ((self.scanfinishmodel?.proDetailModel?.thumbnail) ?? "")), placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
            cell.goodsName.text = self.scanfinishmodel?.proDetailModel?.name
            cell.productCanpanyName.text = self.scanfinishmodel?.proDetailModel?.officeName
            cell.productCode.text = "正品溯源码：" + ((self.scanfinishmodel?.proDetailModel?.regNo) ?? "")
            
            return cell
        }else if indexPath.section == 1{//扫码状态
            let cell:ScanStatusCell = tableView.dequeueReusableCell(withIdentifier: "ScanStatusCellIdentifier", for: indexPath) as! ScanStatusCell
            cell.productdetaiModel = self.scanfinishmodel?.proDetailModel
            cell.SnStr = self.scanfinishmodel?.codeSnId
            var detailStr : String = ""
            
            if self.myProductType == scanProductType.ScanTypeFakeStamp{
                detailStr = "欢迎举报此产品，告诉我们详细信息，经确认后可获得积分奖励"
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 6
                
                let attributeString = NSMutableAttributedString.init(string: detailStr)
                attributeString.setAttributes([NSParagraphStyleAttributeName:paragraphStyle.copy()], range: NSRange.init(location: 0, length: detailStr.characters.count))
                
                cell.infoLabel.attributedText = attributeString
            }else if self.myProductType == scanProductType.ScanTypeSuspicious{
                detailStr = "\("此正品码在不同的设备上已经被查询") \(String(describing: self.scanfinishmodel?.scanrecordForSuspectProductArr!.count ?? 0))  \("次")"
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 6
                
                let attributeString = NSMutableAttributedString.init(string: detailStr)
                //attributeString.setAttributes([NSParagraphStyleAttributeName:paragraphStyle.copy()], range: NSRange.init(location: 0, length: detailStr.characters.count))
                attributeString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, CFStringGetLength(detailStr as CFString)))
                
                cell.infoLabel.attributedText = attributeString
                
                cell.deviceArray = NSMutableArray.init(array: (self.scanfinishmodel?.scanrecordForSuspectProductArr)!)
            
                cell.showScanDevicesBlock = { (data:[ScanrecordForSuspectProductModel]) -> () in
                    self.zpDeviceView.show(inView: UIApplication.shared.keyWindow!)
                }
            }else{
                
            }
            cell.infoLabel.textAlignment = NSTextAlignment.center
            
            cell.resetData(statusType: self.myProductType!, NumStr: "正品溯源码：" + ((self.scanfinishmodel?.codeSnId) ?? ""))
            return cell
        }else if indexPath.section == 2{//商品认证信息
            if indexPath.row == 0 {
                let cell:productDetaiImageCell = tableView.dequeueReusableCell(withIdentifier: "productDetaiImageCellId", for: indexPath) as! productDetaiImageCell
                cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0)
                cell.productDetailImageView.sd_setImage(with: URL.init(string: (self.scanfinishmodel?.proDetailModel?.thumbnail)!), placeholderImage: UIImage.init(named: "qualityBg"))
            
                return cell
            }else{
                let cell:productDetailCell = tableView.dequeueReusableCell(withIdentifier: "productDetailCellId", for: indexPath) as! productDetailCell
                cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0)
            
                let dict:NSDictionary = self.scanfinishmodel?.proDetailModel?.list_ceccGoodsField![indexPath.row - 1] as! NSDictionary
                cell.nameLabel.text = dict.object(forKey: "fieldName") as! String + ":"
                cell.detailLabel.text = dict.object(forKey: "fieldValue") as? String
                
                var type:Int
                let typeStr:String = dict.object(forKey: "fieldType") as! String
                
                type = Int(typeStr)!
                
                cell.resetProductPackageType(type: type)
                return cell
            }
            
            
//            if self.myProductType == scanProductType.ScanTypeQuality {//商品规格信息
//                let cell:productDetailCell = tableView.dequeueReusableCell(withIdentifier: "productDetailCellId", for: indexPath) as! productDetailCell
//                cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0)
//                let dict:NSDictionary = self.scanfinishmodel?.proDetailModel?.list_ceccGoodsField![indexPath.row] as! NSDictionary
//                let titleStr:String = dict.object(forKey: "fieldName")as! String
//                let keyStr:String = dict.object(forKey: "fieldValue")as! String
//                cell.standerLab.text = titleStr + " : " + keyStr
//                return cell
//            }else{//扫码记录
                if indexPath.row == 0 {
                    let cell:ScanDeviceDisCell = tableView.dequeueReusableCell(withIdentifier: "scanDeviceDisCellIdentifier", for: indexPath) as! ScanDeviceDisCell
                    cell.scanNum = (self.scanfinishmodel!.scanrecordForSuspectProductArr?.count)!
                    return cell
                }
                let cell:ScanDeviceDataCell = tableView.dequeueReusableCell(withIdentifier: "ScanDeviceDataCellId", for: indexPath) as! ScanDeviceDataCell
                cell.model = self.scanfinishmodel?.scanrecordForSuspectProductArr?[indexPath.row-1] as! ScanrecordForSuspectProductModel?
                return cell
//            }
        }else if indexPath.section == 3 {
            let cell:companyDetailCell = tableView.dequeueReusableCell(withIdentifier: "companyDetailCellId", for: indexPath) as! companyDetailCell
            cell.clickBlock = {(index:NSInteger) -> () in
                switch index {
                case 0:
                    print("111111")
                    self.zpSelectView.show(inView: UIApplication.shared.keyWindow!, animate: true)
                    
                case 1:
                    print("222222")
                case 2:
                    print("333333")
                default:
                    print("123456")
                }
            }

            return cell
        }
        
        
        let cell:scanLogisticsCell = tableView.dequeueReusableCell(withIdentifier: "scanLogisticsCellId", for: indexPath) as! scanLogisticsCell
        let model:GoodsLotBatchModel = self.scanfinishmodel?.goodsLotBatchArr![indexPath.row] as! GoodsLotBatchModel
        cell.Model = model
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let detailVC = ProductDetailVC()
            detailVC.ProductID = self.scanfinishmodel?.proDetailModel?.ID
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 || section == 3{
            return 0.1
        }
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 1 || section == 3 {
            return nil
        }
        let view:scanProductHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "scanProductHeaderID") as! scanProductHeader
        if section == 2 {
            view.isExpend = self.isExpendOfSectionTwo
//            if self.myProductType == scanProductType.ScanTypeQuality{
                view.titleLab.text = "商品认证信息"
//            }else{
//                view.titleLab.text = "扫码记录"
//            }
        }
        else{
            view.isExpend = self.isExpendOfSectionThree
            view.titleLab.text = "溯源信息"
        }
        
        view.changeValueBlock = {[weak self]()->Void in
            
            if section==2 {
                self?.isExpendOfSectionTwo = !(self?.isExpendOfSectionTwo)!
            }else{
                self?.isExpendOfSectionThree = !(self?.isExpendOfSectionThree)!
            }
            
            self?.tableView.beginUpdates()
            self?.tableView.reloadSections(IndexSet.init(integer: section), with: UITableViewRowAnimation.automatic)
            self?.tableView.endUpdates()
        }
        return view
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }

    private lazy var priceView:priceCompareView = {
        let price = priceCompareView.init(frame: kScreenBounds)
        UIApplication.shared.keyWindow?.addSubview(price)
        return price
    }()
    
    private func priceCompare(){
        self.priceView.VC = self.navigationController
        self.priceView.show = true
    }
    
    lazy var zpSelectView : ZPselectView = {
        let sel = ZPselectView()
        sel.frame = CGRect.init(x: 0, y: 0, width: Double(kScreenWidth - 40), height: Double(kScreenWidth - 40))
        sel.setCustomView(view: sel.addCustomSubViews())
        
        return sel
    }()
    
    lazy var zpDeviceView : ZPselectView = {
        let sel = ZPselectView()
        sel.frame = CGRect.init(x: 0, y: 0, width: Double(kScreenWidth - 40), height: Double(kScreenWidth - 40))
        
        sel.deviceArray = (self.scanfinishmodel?.scanrecordForSuspectProductArr)!
        sel.setCustomView(view: sel.addDeviceTableView())
        return sel
    }()
    
    var zpCustomView : UIView?
    
    
//    private func addCustomSubViews() -> (
//        UIView) {
//        //
//        
//        let contentView = UIView()
//        
//        contentView.frame = CGRect.init(x: 0, y: 0, width: Double(kScreenWidth - 40.0), height: Double(kScreenWidth - 40.0))
//        contentView.layer.masksToBounds = true
//        contentView.layer.cornerRadius = 5
//        
//        let blueBgView = UIView()
//        blueBgView.backgroundColor = Utility.jxColor(fromRGB: 0x00b9de)
//        contentView.addSubview(blueBgView)
//        
//        let logoImageView = UIImageView()
//       
//        logoImageView.backgroundColor = Utility.jxDebugColor()
//        logoImageView.image = UIImage.init(named: "company")
//        contentView.addSubview(logoImageView)
//        
//        let closeButton = UIButton()
//        closeButton.setImage(UIImage.init(named: ""), for: UIControlState.normal)
//        closeButton.setTitle("ⅹ", for: UIControlState.normal)
//        closeButton.backgroundColor = Utility.jxDebugColor()
//        contentView.addSubview(closeButton)
//        
//        let titleLabel = UILabel()
//        titleLabel.text = "企业介绍"
//        titleLabel.textColor = Utility.jxColor(fromRGB: 0x333333)
//        titleLabel.textAlignment = NSTextAlignment.center
//        titleLabel.font = UIFont.systemFont(ofSize: 20)
//        contentView.addSubview(titleLabel)
//        
//        let nameLabel = UILabel()
//        nameLabel.text = "企业名称：正品溯源"
//        nameLabel.textColor = Utility.jxColor(fromRGB: 0x333333)
//        nameLabel.textAlignment = NSTextAlignment.center
//        nameLabel.font = UIFont.systemFont(ofSize: 15)
//        contentView.addSubview(nameLabel)
//        
//        
//        let numLabel = UILabel()
//        numLabel.text = "营业执照注册号：1234567656432425364"
//        numLabel.textColor = Utility.jxColor(fromRGB: 0x333333)
//        numLabel.textAlignment = NSTextAlignment.center
//        numLabel.font = UIFont.systemFont(ofSize: 15)
//        contentView.addSubview(numLabel)
//        
//        let bottomButton = UIButton()
//        
//        bottomButton.setImage(UIImage.init(named: "auth"), for: UIControlState.normal)
//        bottomButton.setTitle("企业信息已认证", for: UIControlState.normal)
//        bottomButton.setTitleColor(Utility.jxColor(fromRGB: 0xaf0808), for: UIControlState.normal)
//        bottomButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        bottomButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10)
//        bottomButton.titleLabel?.backgroundColor = Utility.jxDebugColor()
//
//        bottomButton.imageView?.backgroundColor = Utility.jxDebugColor()
//        contentView.addSubview(bottomButton)
//        
//        blueBgView.mas_makeConstraints { (make:MASConstraintMaker?) in
//            let _ = make?.top.left().equalTo()(contentView)?.offset()(5)
//            let _ = make?.right.equalTo()(contentView.mas_right)?.offset()(-5)
//            let _ = make?.height.mas_equalTo()(100)
//        }
//        logoImageView.mas_makeConstraints { (make:MASConstraintMaker?) in
//            let _ = make?.center.equalTo()(blueBgView)
//            let _ = make?.size.mas_equalTo()(CGSize.init(width: 70, height: 70))
//        }
//        closeButton.mas_makeConstraints { (make:MASConstraintMaker?) in
//            make?.top.right().equalTo()(contentView)
//            make?.size.mas_equalTo()(CGSize.init(width: 30, height: 30))
//        }
//        titleLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
//            make?.top.equalTo()(blueBgView.mas_bottom)?.offset()(20)
//            make?.left.right().equalTo()(contentView)
//            make?.height.mas_equalTo()(20)
//        }
//        nameLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
//            make?.top.equalTo()(titleLabel.mas_bottom)?.offset()(35)
//            make?.left.right().equalTo()(contentView)
//            make?.height.mas_equalTo()(20)
//        }
//        numLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
//            make?.top.equalTo()(nameLabel.mas_bottom)?.offset()(30)
//            make?.left.right().equalTo()(contentView)
//            make?.height.mas_equalTo()(20)
//        }
//        bottomButton.mas_makeConstraints { (make:MASConstraintMaker?) in
//            make?.top.equalTo()(numLabel.mas_bottom)?.offset()(30)
//            make?.left.right().equalTo()(contentView)
//            make?.height.mas_equalTo()(20)
//        }
//        
//        return contentView
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
