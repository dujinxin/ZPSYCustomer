//
//  ScoreCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/22.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ScoreCell: UITableViewCell {

//    private lazy var timerlab:UILabel={
//        let lab=UILabel()
//        lab.text="2017-2-22"
//        return lab
//    }()
    private lazy var detailLab:UILabel={
        let lab=UILabel()
        lab.text="注册成功"
        return lab
    }()
    private lazy var scorelab:UILabel={
        let lab=UILabel()
        lab.text="+100"
        return lab
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        self.selectionStyle=UITableViewCellSelectionStyle.none
        viewinit()
    }
    
    func viewinit(){
        
//        self.contentView.addSubview(self.timerlab)
        self.contentView.addSubview(self.detailLab)
        self.contentView.addSubview(self.scorelab)
        
//        self.timerlab.mas_makeConstraints { (make:MASConstraintMaker?) in
//            let _ = make?.centerY.mas_equalTo()(self.contentView)
//            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.with().offset()(15)
//            let _ = make?.width.equalTo()(100)
//        }
        
        self.detailLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.centerY.mas_equalTo()(self.contentView)
            let _ = make?.left.mas_equalTo()(self.contentView.mas_left)?.with().offset()(15)
        }

        self.scorelab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.centerY.mas_equalTo()(self.contentView)
            let _ = make?.right.mas_equalTo()(self.contentView.mas_right)?.with().offset()(-15)
        }
        
    }
    
    public var scoremodel:scoreModel?{
    
        willSet(newValue){
        
//            let timerStr = CTUtility.string(from: newValue?.time, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
//            self.timerlab.text = timerStr
            self.detailLab.text = newValue?.operation
            self.scorelab.text = newValue?.numbers
        
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
