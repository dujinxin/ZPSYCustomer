//
//  feedbackselectCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/15.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class feedbackselectCell: UITableViewCell {

    var selectresult:((NSInteger)->Void)?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.selectionStyle=UITableViewCellSelectionStyle.none
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        viewinit()
    }
    
    private func viewinit() {
        self.backgroundColor=UIColor.clear
        self.contentView.backgroundColor=UIColor.clear
        let bgview=UIView.init(frame: CGRect.init(x: 15, y: 0, width: kScreenWidth-30, height: 88*kScaleOfScreen))
        bgview.backgroundColor=UIColor.white
        self.contentView.addSubview(bgview)
        
        let arr:NSArray = ["产品问题","扫码问题","意见建议","其他"]
        let w:CGFloat = bgview.frame.size.width/2.0
        let h:CGFloat = bgview.frame.size.height/2.0
        for (index,item) in arr.enumerated() {
            let x:NSInteger = index%2;
            let y:NSInteger = index/2;
            let btn = UIButton.init(frame: CGRect.init(x: (w*CGFloat(x)), y: h*CGFloat(y), width: w, height: h))
            btn.setTitle(String(describing: item), for: UIControlState.normal)
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.tag=index
            btn.addTarget(self, action: #selector(self.btnclickevent(btn:)), for: UIControlEvents.touchUpInside)
            btn.layer.borderColor=UIColor.groupTableViewBackground.cgColor
            btn.layer.borderWidth=0.5
            btn.layer.masksToBounds=true
            bgview.addSubview(btn)
        }
    }
    
    private var selectbtn:UIButton?
    @objc private func btnclickevent(btn:UIButton) -> Void {
        if (self.selectbtn != nil) {
            self.selectbtn?.backgroundColor=UIColor.white
            self.selectbtn?.setTitleColor(UIColor.black, for: UIControlState.normal)
        }
        self.selectbtn=btn
        self.selectbtn?.backgroundColor=UIColor.gray
        self.selectbtn?.setTitleColor(UIColor.white, for: UIControlState.normal)
        if self.selectresult != nil {
            self.selectresult!(btn.tag)
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
