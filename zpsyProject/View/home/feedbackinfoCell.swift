//
//  feedbackinfoCell.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/16.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class feedbackinfoCell: UITableViewCell {

    var suggestresult:((String)->Void)?
    var phoneresult:((String)->Void)?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.selectionStyle=UITableViewCellSelectionStyle.none
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale;
        viewinit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func viewinit(){
        self.backgroundColor=UIColor.clear
        self.contentView.backgroundColor=UIColor.clear
        let bgview=UIView.init(frame: CGRect.init(x: 15, y: 0, width: kScreenWidth-30, height: 212*kScaleOfScreen))
        bgview.backgroundColor=UIColor.white
        self.contentView.addSubview(bgview)
        
        let w = bgview.frame.size.width
        let textview = UITextView.init(frame: CGRect.init(x: 0, y: 0, width: w, height: 170*kScaleOfScreen))
        textview.layer.borderColor=UIColor.groupTableViewBackground.cgColor
        textview.layer.borderWidth=0.5
        let placelab = UILabel.init(frame: CGRect.init(x: 5, y: 6, width: w-10, height: 17))
        placelab.text="请留下您宝贵的建议···"
        placelab.font=UIFont.systemFont(ofSize: 12)
        placelab.textColor=UIColor.gray
        textview.addSubview(placelab)
        bgview.addSubview(textview)
        
        
        let numLab:UILabel=UILabel.init(frame: CGRect.init(x: w-80+15, y: bgview.frame.maxY, width: 80, height: 15*kScaleOfScreen))
        numLab.font=UIFont.systemFont(ofSize: 11)
        numLab.textAlignment=NSTextAlignment.right
        numLab.textColor=UIColor.gray
        self.contentView.addSubview(numLab)

        textview.rac_textSignal().subscribeNext { (x) in
            let str:NSString=x as! NSString
            let num:NSInteger = str.length;
            if (num==0) {
                placelab.isHidden=false;
            }else{
                placelab.isHidden=true;
                if (num>=150) {
                    textview.text=str.substring(to: 149);
                }
            }
            numLab.text="\(num)/150"
            if (self.suggestresult != nil){
                self.suggestresult!(str as String)
            }
        }
        
        let iphonetext = UITextField.init(frame: CGRect.init(x: 0, y: textview.frame.maxY, width: w, height: 42*kScaleOfScreen))
        iphonetext.layer.borderColor=UIColor.groupTableViewBackground.cgColor
        iphonetext.layer.borderWidth=0.5
        iphonetext.placeholder="请留下方便联系到您的手机号码"
        iphonetext.font=UIFont.systemFont(ofSize: 15)
        iphonetext.keyboardType=UIKeyboardType.numberPad
        iphonetext.leftViewMode=UITextFieldViewMode.always
        bgview.addSubview(iphonetext);
        
        
        
        iphonetext.rac_textSignal().subscribeNext { (x) in
            let str:String=x as! String
            if self.phoneresult != nil{
                self.phoneresult!(str)
            }
        }
        
        
        let phonetitle=UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 42*kScaleOfScreen))
        phonetitle.text="手机号码"
        phonetitle.font=UIFont.systemFont(ofSize: 15)
        phonetitle.textAlignment=NSTextAlignment.center
        let  rightview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 42*kScaleOfScreen))
        let speretview = UIView.init(frame: CGRect.init(x: 73, y: 10, width: 1, height: 42*kScaleOfScreen-20))
        speretview.backgroundColor=UIColor.gray
        
        rightview.addSubview(phonetitle)
        rightview.addSubview(speretview)
        iphonetext.leftView=rightview
        
        
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
