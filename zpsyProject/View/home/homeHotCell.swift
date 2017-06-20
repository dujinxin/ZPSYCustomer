//
//  homeHotCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/13.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class homeHotCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shouldRasterize=true
        self.layer.rasterizationScale=UIScreen.main.scale
        self.selectionStyle=UITableViewCellSelectionStyle.none
        viewinit()
    }
    
    
    private lazy var Imgfirst:UIImageView = {
        let img = UIImageView()
        img.isUserInteractionEnabled=true
        img.tag = 0
        img.contentMode = UIViewContentMode.scaleAspectFill
        img.clipsToBounds = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.clickevent(gesture:)))
        img.addGestureRecognizer(tap)
        return img
    }()
    private lazy var Imgsecond:UIImageView = {
        let img = UIImageView()
        img.isUserInteractionEnabled=true
        img.tag = 1
        img.contentMode=UIViewContentMode.scaleAspectFill
        img.clipsToBounds=true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.clickevent(gesture:)))
        img.addGestureRecognizer(tap)
        return img
    }()
    private lazy var Imgthird:UIImageView = {
        let img = UIImageView()
        img.isUserInteractionEnabled=true
        img.tag = 2
        img.contentMode=UIViewContentMode.scaleAspectFill
        img.clipsToBounds=true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.clickevent(gesture:)))
        img.addGestureRecognizer(tap)
        return img
    }()
    
    
    private lazy var firstLab:UILabel = {
    
        let lab = UILabel()
        lab.textColor = UIColor.white
        lab.font = UIFont.boldSystemFont(ofSize: 13)
        lab.textAlignment = NSTextAlignment.center
        lab.text = "跑步鸡"
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        lab.addSubview(lineView)
        
        lineView.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.bottom.mas_equalTo()(lab.mas_bottom)
            let _ = make?.centerX.mas_equalTo()
            let _ = make?.height.equalTo()(1)
            let _ = make?.width.equalTo()(40)
        })
        return lab
    }()
    private lazy var secondLab:UILabel = {
        
        let lab = UILabel()
        lab.textColor = UIColor.white
        lab.font = UIFont.boldSystemFont(ofSize: 13)
        lab.textAlignment = NSTextAlignment.center
        lab.text = "古树普茶"
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        lab.addSubview(lineView)
        
        lineView.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.bottom.mas_equalTo()(lab.mas_bottom)
            let _ = make?.centerX.mas_equalTo()
            let _ = make?.height.equalTo()(1)
            let _ = make?.width.equalTo()(40)
        })
        return lab
    }()
    
    private lazy var thirdLab:UILabel = {
        
        let lab = UILabel()
        lab.textColor = UIColor.white
        lab.font = UIFont.boldSystemFont(ofSize: 13)
        lab.textAlignment = NSTextAlignment.center
        lab.text = "新西兰红酒"
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        lab.addSubview(lineView)
        
        lineView.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.bottom.mas_equalTo()(lab.mas_bottom)
            let _ = make?.centerX.mas_equalTo()
            let _ = make?.height.equalTo()(1)
            let _ = make?.width.equalTo()(40)
        })
        return lab
    }()
    
    private func viewinit() {
        
        let titlelab = UILabel()
        titlelab.text = "正品优选"
        titlelab.font = UIFont.systemFont(ofSize: 12);
        titlelab.textColor = UIColor.black
        self.contentView.addSubview(titlelab)
        titlelab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(15)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.offset()(0)
            let _ = make?.height.equalTo()(35)
        }
        
        let anymore = UIButton()
        anymore.setTitle("更多", for: UIControlState.normal)
        anymore.setTitleColor(UIColor.black, for: UIControlState.normal)
        anymore.titleLabel?.font=UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(anymore)
        anymore.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-15)
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)?.offset()(0)
            let _ = make?.height.equalTo()(35)
        }

        anymore.rac_signal(for: UIControlEvents.touchUpInside).subscribeNext { (x:Any?) in
            
            let hotVC = HotProductVc.init()
            hotVC.hidesBottomBarWhenPushed = true
            CTUtility.findViewController(self).navigationController?.pushViewController(hotVC, animated: true)
        }
        
        
        self.contentView.addSubview(self.Imgfirst)
        self.contentView.addSubview(self.Imgsecond)
        self.contentView.addSubview(self.Imgthird)

        self.Imgfirst.addSubview(self.firstLab)
        self.Imgsecond.addSubview(self.secondLab)
        self.Imgthird.addSubview(self.thirdLab)
        
        self.firstLab.mas_makeConstraints({[weak self] (make:MASConstraintMaker?) in
            
            let _ = make?.left.mas_equalTo()(self?.Imgfirst.mas_left)
            let _ = make?.right.mas_equalTo()(self?.Imgfirst.mas_right)
            let _ = make?.centerY.mas_equalTo()
            let _ = make?.height.equalTo()(25)
        })
        self.secondLab.mas_makeConstraints({[weak self] (make:MASConstraintMaker?) in
            
            let _ = make?.left.mas_equalTo()(self?.Imgsecond.mas_left)
            let _ = make?.right.mas_equalTo()(self?.Imgsecond.mas_right)
            let _ = make?.centerY.mas_equalTo()
            let _ = make?.height.equalTo()(25)
        })
        self.thirdLab.mas_makeConstraints({[weak self] (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self?.Imgthird.mas_left)
            let _ = make?.right.mas_equalTo()(self?.Imgthird.mas_right)
            let _ = make?.centerY.mas_equalTo()
            let _ = make?.height.equalTo()(25)
        })
        
        self.Imgfirst.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(titlelab.mas_bottom)?.offset()(0)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-10)
            
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(15)
            let _ = make?.right.mas_equalTo()(self.Imgsecond.mas_left)?.offset()(-5)
            let _ = make?.width.equalTo()(self.Imgsecond)
            let _ = make?.height.equalTo()(78*kScaleOfScreen)
        }
        self.Imgsecond.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(titlelab.mas_bottom)?.offset()(0)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-10)
            
            let _ = make?.left.mas_equalTo()(self.Imgfirst.mas_right)?.offset()(5)
            let _ = make?.right.mas_equalTo()(self.Imgthird.mas_left)?.offset()(-5)
            let _ = make?.width.equalTo()(self.Imgthird)
            let _ = make?.height.equalTo()(78*kScaleOfScreen)
        }
        self.Imgthird.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(titlelab.mas_bottom)?.offset()(0)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-10)
            
            let _ = make?.left.mas_equalTo()(self.Imgsecond.mas_right)?.offset()(5)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-15)
            let _ = make?.width.equalTo()(self.Imgfirst)
            let _ = make?.height.equalTo()(78*kScaleOfScreen)
        }
    }
    

    @objc private func clickevent(gesture:UIGestureRecognizer){
        let view:UIImageView = gesture.view as! UIImageView;

        let model:bannerModel = modelArr![view.tag]
        let urlStr = model.jumpUrl
        
        let detailVc = ExposureDetailVC()
        detailVc.urlStr = urlStr
        detailVc.thatID = model.field4 ?? model.id
        detailVc.webtype = "2"
        detailVc.imgStr = model.image
        detailVc.detilStr = model.detail
        detailVc.hidesBottomBarWhenPushed = true
        CTUtility.findViewController(self).navigationController?.pushViewController(detailVc, animated: true)
    
    }
    
    public var modelArr:[bannerModel]? {
        didSet{
        
            self.Imgfirst.isHidden = true
            self.Imgsecond.isHidden = true
            self.Imgthird.isHidden = true
            if modelArr == nil {
                return
            }
            if((modelArr?.count)!>=1){
                self.Imgfirst.isHidden = false
                let model:bannerModel = modelArr![0]
                self.Imgfirst.locoaSdImageCache(withURL: model.image, placeholderImageName: PlaceHoldeImageStr)
                self.firstLab.text = model.title
                self.firstLab.isHidden = true
            }
            if((modelArr?.count)!>=2){
                self.Imgsecond.isHidden = false
                let model:bannerModel = modelArr![1]
                self.Imgsecond.locoaSdImageCache(withURL: model.image, placeholderImageName: PlaceHoldeImageStr)
                self.secondLab.text = model.title
                self.secondLab.isHidden = true
            }
            if((modelArr?.count)!>=3){
                self.Imgthird.isHidden = false
                let model:bannerModel = modelArr![2]
                self.Imgthird.locoaSdImageCache(withURL: model.image, placeholderImageName: PlaceHoldeImageStr)
                self.thirdLab.text = model.title
                self.thirdLab.isHidden = true
            }
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
