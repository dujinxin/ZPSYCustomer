//
//  feedReportSuccessView.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/17.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class feedReportSuccessView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
//    public var showtype:NSInteger?
    
    init(frame: CGRect, showtype:NSInteger) {
        super.init(frame: frame)
        viewinit(showtype: showtype)
    }
    
    func viewinit(showtype:NSInteger) {
        
        self.backgroundColor=UIColor.white
        
        let image = UIImageView.init(image: UIImage.init(named: "successSymbol"))
        
        let TitleLab = UILabel.init()
        TitleLab.text="提交成功!"
        TitleLab.textAlignment=NSTextAlignment.center
        
        let deslab=UILabel.init()
        deslab.text="您的意见反馈信息我们已经收到"
        deslab.font=UIFont.systemFont(ofSize: 13)
        deslab.textAlignment=NSTextAlignment.center
        
        let desdetaillab=UILabel.init()
        desdetaillab.text="您的意见反馈信息我们已经收到详细"
        desdetaillab.font=UIFont.systemFont(ofSize: 13)
        desdetaillab.textAlignment=NSTextAlignment.center
        
        TitleLab.addSubview(image)
        self.addSubview(TitleLab)
        self.addSubview(deslab)
        self.addSubview(desdetaillab)
        
        TitleLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.centerX.mas_equalTo()(self)
            let _ = make?.top.mas_equalTo()(self)?.with().offset()(40)
        }
        
        image.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.centerY.mas_equalTo()(TitleLab)
            let _ = make?.right.mas_equalTo()(TitleLab.mas_left)?.with().offset()(-10)
        }
        
        deslab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.centerX.mas_equalTo()(self)
            let _ = make?.top.mas_equalTo()(TitleLab.mas_bottom)?.with().offset()(20)
            let _ = make?.height.equalTo()(13)
        }
        
        desdetaillab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.centerX.mas_equalTo()(self)
            let _ = make?.top.mas_equalTo()(deslab.mas_bottom)
        }
        
        
        
        if showtype==1 {//举报提交成功
            TitleLab.text="举报成功!"
            deslab.text="您的举报信息我们已经收到"
            desdetaillab.text="我们将尽快核实信息并与您取得联系"
        }else{//意见反馈提交成功
        
            TitleLab.text="提交成功!"
            deslab.text="您的意见反馈信息我们已经收到"
            desdetaillab.text=""
        }
    
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
