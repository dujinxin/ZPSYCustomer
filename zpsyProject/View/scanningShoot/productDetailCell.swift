//
//  productDetailCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/20.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit
//MARK: productDetailCell 商品生产信息
class productDetailCell: UITableViewCell {

    
    public var nameLabel:UILabel = {
    
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = Utility.color(withHex: 0x333333)
        lab.backgroundColor = Utility.jxDebugColor()
        lab.text = "规格等级："
        return lab
    }()
    public var detailLabel:UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = Utility.color(withHex: 0x333333)
        lab.backgroundColor = Utility.jxDebugColor()
        lab.text = ""
        return lab
    }()
    public var detailImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Utility.jxDebugColor()
        return imageView
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle=UITableViewCellSelectionStyle.none
        //self.separatorInset=UIEdgeInsetsMake(0, kScreenWidth, 0, 0)
        
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.detailLabel)
        self.contentView.addSubview(self.detailImageView)
        
        self.nameLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            //let _ = make?.edges.equalTo()(UIEdgeInsetsMake(5, 30, 5, 15))
            let _ = make?.top.equalTo()(self.contentView.mas_top)?.offset()(15)
            let _ = make?.left.equalTo()(self.contentView.mas_left)?.offset()(25)
            let _ = make?.width.mas_equalTo()(70)
            let _ = make?.height.mas_equalTo()(14)
        }
        
        self.detailLabel.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.equalTo()(self.nameLabel.mas_top)
            let _ = make?.left.equalTo()(self.nameLabel.mas_right)
            let _ = make?.right.equalTo()(self.contentView.mas_right)?.offset()(-25)
            let _ = make?.height.mas_equalTo()(14)
            
            let _ = make?.bottom.equalTo()(self.contentView.mas_bottom)?.offset()(-15)
        }
        
        self.detailImageView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.equalTo()(self.nameLabel.mas_top)
            let _ = make?.left.equalTo()(self.nameLabel.mas_right)
            let _ = make?.width.and().height().mas_equalTo()(0);
            //let _ = make?.bottom.equalTo()(self.contentView.mas_bottom)?.offset()(-15)
        }
        
        
    }
    //字段类型：0文本 1号码 2数值 3金额 4下拉菜单 5日期时间 6图片文件
    
    func resetProductPackageType(type:Int) -> Void {
        if type == 0 || type == 1 || type == 2 || type == 3 || type == 5 {
            self.detailLabel.mas_remakeConstraints { (make:MASConstraintMaker?) in
                let _ = make?.top.equalTo()(self.nameLabel.mas_top)
                let _ = make?.left.equalTo()(self.nameLabel.mas_right)
                let _ = make?.right.equalTo()(self.contentView.mas_right)?.offset()(-25)
                let _ = make?.height.mas_equalTo()(14)
                
                let _ = make?.bottom.equalTo()(self.contentView.mas_bottom)?.offset()(-15)
            }
            
            self.detailImageView.mas_remakeConstraints { (make:MASConstraintMaker?) in
                let _ = make?.top.equalTo()(self.nameLabel.mas_top)
                let _ = make?.left.equalTo()(self.nameLabel.mas_right)
                let _ = make?.width.and().height().mas_equalTo()(0);
                //let _ = make?.bottom.equalTo()(self.contentView.mas_bottom)?.offset()(-15)
            }
        }else if type == 6{
            self.detailLabel.mas_remakeConstraints { (make:MASConstraintMaker?) in
                let _ = make?.top.equalTo()(self.nameLabel.mas_top)
                let _ = make?.left.equalTo()(self.nameLabel.mas_right)
                let _ = make?.right.equalTo()(self.contentView.mas_right)?.offset()(-25)
                let _ = make?.height.mas_equalTo()(0)
                
                let _ = make?.bottom.equalTo()(self.contentView.mas_bottom)?.offset()(-15)
            }
            
            self.detailImageView.mas_remakeConstraints { (make:MASConstraintMaker?) in
                let _ = make?.top.equalTo()(self.nameLabel.mas_top)
                let _ = make?.left.equalTo()(self.nameLabel.mas_right)
                let _ = make?.width.and().height().mas_equalTo()(50*kPercent);
                let _ = make?.bottom.equalTo()(self.contentView.mas_bottom)?.offset()(-15)
            }
        }else{
            
        }
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

//MARK: productDetaiImageCell 原产地大图
class productDetaiImageCell: UITableViewCell {
    
    public var productDetailImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Utility.jxDebugColor()
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.productDetailImageView)
        
        self.productDetailImageView .mas_makeConstraints { (make:MASConstraintMaker?) in
            make?.top.left().right().bottom().equalTo()(self.contentView)
            make?.height.mas_equalTo()(300)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: companyDetailCell  企业信息
class companyDetailCell:UITableViewCell{
    
    var clickBlock: ((_ index:NSInteger) -> ())?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = Utility.jxColor(fromRGB: 0xffffff);
        let imageViewWidth:CGFloat = 60
        let space:CGFloat = (kScreenWidth - imageViewWidth * 3)/4
        
        let titleArray = ["企业介绍","检测报告","认证信息"];
        let imageNameArray = ["companyProfile","examiningReport","authentication"];
      
        for i in 0..<1 {
            let imageView : UIImageView = {
                let imageView = UIImageView()
                imageView.backgroundColor = Utility.jxDebugColor()
                imageView.image = UIImage.init(named: imageNameArray[i])
                imageView.tag = i
                imageView.isUserInteractionEnabled = true
                return imageView
            }()
            let label : UILabel = {
                let l = UILabel()
                l.backgroundColor = Utility.jxDebugColor()
                l.textAlignment = NSTextAlignment.center
                l.font = UIFont.systemFont(ofSize: 16)
                l.text = titleArray[i]
                l.tag = i
                l.isUserInteractionEnabled = true
                return l
            }()
            
            self.contentView.addSubview(imageView)
            self.contentView.addSubview(label)
            
            let tap1 : UITapGestureRecognizer = {
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
                return tap
            }()
            let tap2 : UITapGestureRecognizer = {
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
                return tap
            }()
            
            imageView.addGestureRecognizer(tap1)
            label.addGestureRecognizer(tap2)
  
            imageView.mas_makeConstraints({ (make:MASConstraintMaker?) in
                let _ = make?.top.equalTo()(self.contentView)?.offset()(15);
                //let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(space + (space +imageViewWidth) *i);
                let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(space);
                let _ = make?.size.mas_equalTo()(CGSize.init(width: imageViewWidth, height: imageViewWidth));
            })
            label.mas_makeConstraints({ (make:MASConstraintMaker?) in
                let _ = make?.top.equalTo()(imageView.mas_bottom)?.offset()(15);
                let _ = make?.centerX.mas_equalTo()(imageView);
                let _ = make?.height.mas_equalTo()(20);
                let _ = make?.width.mas_equalTo()(80);
                let _ = make?.bottom.equalTo()(self.contentView.mas_bottom)?.offset()(-15)
            })
        }
    }
    func tapClick(tap:UITapGestureRecognizer) -> Void {
        //
        print("click:\(String(describing: tap.view?.tag))")
        self.clickBlock!((tap.view?.tag)!)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
