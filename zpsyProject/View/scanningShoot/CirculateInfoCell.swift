//
//  CirculateInfoCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/2.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class CirculateInfoCell: UITableViewCell {

    private var leftTimerLab:UILabel?
    private var rightTimerLab:UILabel?
    
    private var leftDetailLab:UILabel?
    private var rightDetailLab:UILabel?
    
    private var leftline:UIView?
    private var rightline:UIView?
    
    private var leftCircle:UIView?
    private var rightCircle:UIView?
    
    private var centerImg:UIImageView = {
    
        let img = UIImageView()
        img.image = UIImage.init(named:"hollow_0")
        return img
    }()
    
    private let arr = [
                       ["img":"hollow_0","color":Utility.color(withHex: 0xec6941)],
                       ["img":"hollow_1","color":Utility.color(withHex: 0xff00ff)],
                       ["img":"hollow_2","color":Utility.color(withHex: 0xfff100)],
                       ["img":"hollow_3","color":Utility.color(withHex: 0x0068b7)],
                       ["img":"hollow_4","color":Utility.color(withHex: 0x00b7ee)]
                       ]
    
    
    
    public func setdata(timeStr:String,detailstr:String,indexrow:NSInteger){
        
        self.rightTimerLab?.text = timeStr
        self.leftTimerLab?.text = timeStr
        self.rightDetailLab?.text = detailstr
        self.leftDetailLab?.text = detailstr
        if indexrow%2 == 0 {
            Showleft(true)
        }else{
            Showleft(false)
        }
    }
    
    private func Showleft(_ status:Bool){
    
        self.leftDetailLab?.isHidden = status
        self.leftTimerLab?.isHidden = status
        self.leftCircle?.isHidden = status
        self.leftline?.isHidden = status
        self.rightDetailLab?.isHidden = !status
        self.rightTimerLab?.isHidden = !status
        self.rightCircle?.isHidden = !status
        self.rightline?.isHidden = !status
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.selectionStyle=UITableViewCellSelectionStyle.none
        self.separatorInset=UIEdgeInsetsMake(0, kScreenWidth, 0, 0)
        
        let columLine = getLine()
        leftline = getLine()
        rightline = getLine()
        
        leftCircle = getCircle()
        rightCircle = getCircle()
        
        leftTimerLab=getlab("2017-10-10", aligen: NSTextAlignment.right)
        rightTimerLab=getlab("2017-10-10", aligen: NSTextAlignment.left)
        
        leftDetailLab=getlab("", aligen: NSTextAlignment.left)
        rightDetailLab=getlab("", aligen: NSTextAlignment.left)
    
        self.contentView.addSubview(columLine)
        self.contentView.addSubview(self.centerImg)
        self.contentView.addSubview(self.leftline!)
        self.contentView.addSubview(self.rightline!)
        self.contentView.addSubview(self.leftCircle!)
        self.contentView.addSubview(self.rightCircle!)
        self.contentView.addSubview(self.leftTimerLab!)
        self.contentView.addSubview(self.rightTimerLab!)
        self.contentView.addSubview(self.leftDetailLab!)
        self.contentView.addSubview(self.rightDetailLab!)
        
        columLine.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)
            let _ = make?.centerX.mas_equalTo()(self.contentView)
            let _ = make?.size.equalTo()(CGSize.init(width: 2, height: 13))
        }
        
        centerImg.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(columLine.mas_bottom)?.offset()(4)
            let _ = make?.centerX.mas_equalTo()(self.contentView)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(-10)
        }
        
        leftline!.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.right.mas_equalTo()(self.centerImg.mas_left)?.offset()(-4)
            let _ = make?.centerY.mas_equalTo()(self.centerImg)
            let _ = make?.size.equalTo()(CGSize.init(width: 15*kScaleOfScreen, height: 1))
        })
        
        rightline!.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.centerImg.mas_right)?.offset()(4)
            let _ = make?.centerY.mas_equalTo()(self.centerImg)
            let _ = make?.size.equalTo()(CGSize.init(width: 15*kScaleOfScreen, height: 1))
        })
        
        leftCircle!.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.right.mas_equalTo()(self.leftline?.mas_left)
            let _ = make?.centerY.mas_equalTo()(self.centerImg)
            let _ = make?.size.equalTo()(CGSize.init(width: 4, height: 4))
        })
        rightCircle!.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.rightline?.mas_right)
            let _ = make?.centerY.mas_equalTo()(self.centerImg)
            let _ = make?.size.equalTo()(CGSize.init(width: 4, height: 4))
        })
        
        leftTimerLab!.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.right.mas_equalTo()(self.leftCircle?.mas_left)?.offset()(-5)
            let _ = make?.centerY.mas_equalTo()(self.centerImg)
            let _ = make?.width.equalTo()(70)
        })
        rightTimerLab!.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.rightCircle?.mas_right)?.offset()(5)
            let _ = make?.centerY.mas_equalTo()(self.centerImg)
            let _ = make?.width.equalTo()(70)
        })

        leftDetailLab!.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.right.mas_equalTo()(self.leftTimerLab?.mas_left)?.offset()(-5)
            let _ = make?.centerY.mas_equalTo()(self.centerImg)
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(10)
//            let _ = make?.bottom.mas_equalTo()(self.leftTimerLab?.mas_bottom)
        })
        rightDetailLab!.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.rightTimerLab?.mas_right)?.offset()(5)
            let _ = make?.centerY.mas_equalTo()(self.centerImg)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.offset()(-10)
//            let _ = make?.bottom.mas_equalTo()(self.rightTimerLab?.mas_bottom)
        })
        
    }
    
    private func getlab(_ labStr:String, aligen:NSTextAlignment)-> UILabel{
        let lab  = UILabel()
        lab.numberOfLines=3
        lab.text = labStr
        lab.textColor = Utility.color(withHex: 0x333333)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textAlignment = aligen
        return lab
    }

    private func getLine()->UIView{
        let view=UIView()
        view.backgroundColor=UIColor.groupTableViewBackground
        return view
    }
    
    private func getCircle()->UIView{
        let view=UIView()
        view.backgroundColor = arr[0]["color"] as! UIColor?
        view.layer.cornerRadius = 2
        return view
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
