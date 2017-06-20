//
//  ScanDeviceDataCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/2.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ScanDeviceDataCell: UITableViewCell {

    
    private var TimerLab:UILabel?
    private var DeviceTypeLab:UILabel?
    private var AddressLab:UILabel?
    
    public var model:ScanrecordForSuspectProductModel?{
    
        didSet{
            self.TimerLab?.text = CTUtility.string(from: model?.scanTime, sourceformat: "yyyy-MM-dd HH:mm:ss.s", toFormat: "yyyy-MM-dd")
            self.DeviceTypeLab?.text = model?.model
            self.AddressLab?.text = model?.city
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.separatorInset=UIEdgeInsetsMake(0, 15, 0, 15)
        self.selectionStyle=UITableViewCellSelectionStyle.none
        
        let TimeLab=getlab("2017-2-17", aligen: NSTextAlignment.center)
        let deviceTypeLab=getlab("IPhone7", aligen: NSTextAlignment.center)
        let dresslab=getlab("北京", aligen: NSTextAlignment.center)
        let leftLine = getlineView()
        let rightLine = getlineView()
        
        TimerLab=TimeLab
        DeviceTypeLab=deviceTypeLab
        AddressLab=dresslab
        
        self.contentView.addSubview(TimeLab)
        self.contentView.addSubview(deviceTypeLab)
        self.contentView.addSubview(dresslab)
        self.contentView.addSubview(leftLine)
        self.contentView.addSubview(rightLine)
    
        let w = (kScreenWidth-30)/3.0
        let h = 40
        
        TimeLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.offset()(15)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)
            let _ = make?.width.equalTo()(w)
            let _ = make?.height.equalTo()(h)
        }
        leftLine.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)
            let _ = make?.left.mas_equalTo()(TimeLab.mas_right)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)
            let _ = make?.width.equalTo()(1)
            let _ = make?.height.equalTo()(h)
        }
        deviceTypeLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)
            let _ = make?.left.mas_equalTo()(leftLine.mas_right)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(0)
            let _ = make?.width.equalTo()(w)
            let _ = make?.height.equalTo()(h)
        }
        rightLine.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)
            let _ = make?.left.mas_equalTo()(deviceTypeLab.mas_right)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)
            let _ = make?.width.equalTo()(1)
            let _ = make?.height.equalTo()(h)
        }
        dresslab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(self.contentView.mas_top)
            let _ = make?.left.mas_equalTo()(rightLine.mas_right)
            let _ = make?.bottom.mas_equalTo()(self.contentView.mas_bottom)?.offset()(0)
            let _ = make?.width.equalTo()(w)
            let _ = make?.height.equalTo()(h)
        }
    }
    
    private func getlineView()->UIView{
        let view=UIView()
        view.backgroundColor=UIColor.groupTableViewBackground
        return view
    }
    
    private func getlab(_ labStr:String, aligen:NSTextAlignment)-> UILabel{
        let lab  = UILabel()
        lab.numberOfLines=0
        lab.text = labStr
        lab.textColor = UIColor.init(white: 0.3, alpha: 1)
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textAlignment = aligen
        return lab
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
