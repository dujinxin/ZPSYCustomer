//
//  ScanStatusCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/1.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ScanStatusCell: UITableViewCell {
    
    
    public var productdetaiModel:productDetailModel?
    public var SnStr: String?
    
    public var deviceArray:NSMutableArray?
    
    
    private lazy var bgImage:UIImageView={
        let img = UIImageView()
        img.image = UIImage.init(named: "qualityBg")
        img.contentMode = UIViewContentMode.scaleAspectFill
        return img
    }()
    
    private lazy var titleLabel:UILabel={
        let lab = UILabel()
        lab.textColor = UIColor.black
        lab.text = "正品溯源权威认证"
        lab.textAlignment = NSTextAlignment.center
        lab.font=UIFont.systemFont(ofSize: 18)
        lab.backgroundColor = UIColor.red
        return lab
    }()
    private lazy var resultButton:UIButton={
        
        let btn=UIButton()
        btn.backgroundColor = UIColor.blue
        btn.setTitle("正品", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.backgroundColor = kColor_red
        btn.backgroundColor = UIColor.blue
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5)
        return btn
    }()
    lazy var infoLabel:UILabel={
        let lab = UILabel()
        lab.textColor = UIColor.white
        lab.backgroundColor = Utility.jxDebugColor()
        lab.text = "正品溯源码：" + "111122223333444"
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textAlignment = NSTextAlignment.center
        lab.numberOfLines = 0
        return lab
    }()
    
    private lazy var detailButton:UIButton={
        
        let btn=UIButton()
        btn.setTitle("查看详情", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        btn.backgroundColor = kColor_red
        return btn
    }()
    
    private lazy var reportButton:UIButton={
        let btn=UIButton()
        btn.setTitle("举报有奖", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        btn.backgroundColor = kColor_red
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle=UITableViewCellSelectionStyle.none
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.contentView.addSubview(self.bgImage)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.resultButton)
        self.contentView.addSubview(self.infoLabel)
        
        self.contentView.addSubview(self.reportButton)
        
        viewInitMas()
    }
    
    func viewInitMas() {
        let space :CGFloat = 30
        self.bgImage.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.left().right().bottom().equalTo()(self.contentView);
        }
        
        
        self.titleLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.equalTo()(self.contentView.mas_top)?.offset()(space)
            let _ = make?.left.equalTo()(self.contentView.mas_left)?.offset()(20)
            let _ = make?.right.equalTo()(self.contentView.mas_right)?.offset()(-20)
            let _ = make?.height.mas_equalTo()(30)
        }
        
        self.resultButton.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.equalTo()(self.titleLabel.mas_bottom)?.offset()(space)
            let _ = make?.centerX.mas_equalTo()(self.titleLabel.mas_centerX)
            //let _ = make?.left.equalTo()(self.contentView.mas_left)?.offset()(20)
            //let _ = make?.right.equalTo()(self.contentView.mas_right)?.offset()(-20)
            //let _ = make?.height.mas_equalTo()(30)
            //let _ = make?.width.mas_equalTo()(80)
            let _ = make?.size.mas_equalTo()(CGSize.init(width: 100, height: 30))
        }
        self.infoLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(50)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-50)
            let _ = make?.top.mas_equalTo()(self.resultButton.mas_bottom)?.offset()(5)
            //let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-15)
            let _ = make?.height.equalTo()(0)
        }
        
        reportButton.rac_signal(for: UIControlEvents.touchUpInside).subscribeNext({ (x:Any?) in
            
            let report = ReportVC.init(style: UITableViewStyle.grouped)
            report.PruductId = self.productdetaiModel?.ID
            report.SNString = self.SnStr
            report.porductModel = self.productdetaiModel
            CTUtility.findViewController(self).navigationController?.pushViewController(report, animated: true)
        })

        resetLayout(scanProductType.ScanTypeQuality)
        
    }
    

    private func resetLayout( _ statusType:scanProductType){
        
        var bgImgStr:String = "qualityBg"
        var statusImgStr:String = "quality"
        var resultTitleStr:String = "正品"
        var detailStr:String = "您扫描的商品为中日韩官方政府认可\n第三方正品溯源平台认可正品"
        
        if statusType==scanProductType.ScanTypeQuality {
            
            self.infoLabel.mas_remakeConstraints{ (make:MASConstraintMaker?) in
                let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(50)
                let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-50)
                let _ = make?.top.mas_equalTo()(self.resultButton.mas_bottom)?.offset()(5)
                let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-15)
                let _ = make?.height.equalTo()(0)
            }
            self.reportButton.mas_remakeConstraints({ (make:MASConstraintMaker?) in
                let _ = make?.width.equalTo()(0)
            })
        }else {
        
            if statusType == scanProductType.ScanTypeFakeStamp{
                bgImgStr="forgeBg"
                statusImgStr = "forge"
                resultTitleStr = "伪品"
                //detailStr = "欢迎举报此产品，告诉我们详细信息，经确认后可获得积分奖励"
                self.infoLabel.mas_remakeConstraints{ (make:MASConstraintMaker?) in
                    let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(50)
                    let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-50)
                    let _ = make?.top.mas_equalTo()(self.resultButton.mas_bottom)?.offset()(5)
                    let _ = make?.height.equalTo()(75)
                }
                
                self.reportButton.mas_remakeConstraints({ (make:MASConstraintMaker?) in
                    let _ = make?.centerX.mas_equalTo()(self.titleLabel.mas_centerX)
                    let _ = make?.top.mas_equalTo()(self.infoLabel.mas_bottom)?.offset()(10)
                    let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-20)
                    let _ = make?.width.equalTo()(100)
                    let _ = make?.height.equalTo()(26)
                })
                
                
//                NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
//                NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle};
//                CGRect rect = [recordEntity.Content boundingRectWithSize:CGSizeMake(kScreenWidth -30, 1000) options:option attributes:attributes context:nil];
//                
//                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:recordEntity.Content];
//                [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
            }else{
                bgImgStr="doubtBg"
                statusImgStr = "doubt"
                resultTitleStr = "可疑品"
                //detailStr = "此正品码在不同的设备上已经被查询" + \() + "次"
                self.infoLabel.mas_remakeConstraints{ (make:MASConstraintMaker?) in
                    let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(50)
                    let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-50)
                    let _ = make?.top.mas_equalTo()(self.resultButton.mas_bottom)?.offset()(5)
                    let _ = make?.height.equalTo()(50)
                }
                self.reportButton.mas_remakeConstraints({ (make:MASConstraintMaker?) in
                    let _ = make?.left.mas_equalTo()(self.titleLabel.mas_centerX)?.offset()(30)
                    let _ = make?.top.mas_equalTo()(self.infoLabel.mas_bottom)?.offset()(10)
                    let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-20)
                    let _ = make?.width.equalTo()(100)
                    let _ = make?.height.equalTo()(26)
                })
                
                self.contentView.addSubview(self.detailButton)
                self.detailButton.mas_makeConstraints({ (make:MASConstraintMaker?) in
                    let _ = make?.right.mas_equalTo()(self.titleLabel.mas_centerX)?.offset()(-30)
                    let _ = make?.top.mas_equalTo()(self.reportButton)
                    //let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-20)
                    let _ = make?.size.equalTo()(self.reportButton)
                })
                
                self.detailButton.addTarget(self, action: #selector(showScanDevices), for: .touchUpInside)
            }
        
            
        }
        self.bgImage.image = UIImage.init(named: bgImgStr)
        //self.titleLabel.text=TitleStr
        self.resultButton.setTitle(resultTitleStr, for: UIControlState.normal)
        self.resultButton.setImage(UIImage.init(named: statusImgStr), for: UIControlState.normal)
        //self.infoLabel.text = detailStr
        
//        self.bgImage.mas_remakeConstraints { (make:MASConstraintMaker?) in
//            let _ = make?.top.left().right().bottom().equalTo()(self.contentView);
//        }
        
        //self.layoutIfNeeded()
    }
    
    public func resetData(statusType:scanProductType,NumStr:String){
        //self.resultButton.text=NumStr
        resetLayout(statusType)
    }
    
    
    var showScanDevicesBlock : ((_ deviceArr:[ScanrecordForSuspectProductModel]) -> ())?
    
    public func showScanDevices() {
        
        self.showScanDevicesBlock?(self.deviceArray as! [ScanrecordForSuspectProductModel])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
