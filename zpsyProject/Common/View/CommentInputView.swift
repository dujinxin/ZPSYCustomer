//
//  CommentInputView.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/3.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

enum commentType:NSInteger {
    case commentProduct = 0 ,//商品
    commentExpouse = 1 ,     //曝光
    commentPrefrence = 2     //优选
}

class CommentInputView: UIView,UITextFieldDelegate {

    public var resourcesId : String? = ""
    public var Mycommenttype:commentType? = .commentProduct
    public var successBlock:(()->Void)?
    
    private lazy var MyInputField: UITextField = {
        let textfield = UITextField.init()
        textfield.layer.borderWidth=1
        textfield.layer.borderColor=UIColor.groupTableViewBackground.cgColor
        textfield.layer.cornerRadius=3
        textfield.font = UIFont.systemFont(ofSize: 15)
        textfield.placeholder="说点什么吧"
        textfield.returnKeyType = UIReturnKeyType.send
        
        let img = UIImageView.init(image: UIImage.init(named: "writing"))
        textfield.leftView = img
        textfield.leftViewMode = UITextFieldViewMode.always
        return textfield
    }()
    private var IsEdit:Bool = true
    
    init(_ isedit:Bool) {
        super.init(frame: CGRect.zero)
        self.backgroundColor=UIColor.white
        IsEdit = isedit
        viewInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.init(colorLiteralRed: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1)
        viewInit()
    }
    
    private func viewInit(){
        
        self.addSubview(self.MyInputField)
        
        self.MyInputField.delegate=self
        
        self.MyInputField.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.mas_left)?.offset()(15)
            let _ = make?.top.mas_equalTo()(self.mas_top)?.offset()(10)
            let _ = make?.right.mas_equalTo()(self.mas_right)?.offset()(-15)
            let _ = make?.bottom.mas_equalTo()(self.mas_bottom)?.offset()(-10)
        }
        
    }
    
    //发送信息
    private func senderMessage(textStr:String){
    
        MBProgressHUD.showAnimationtoView(CTUtility.findViewController(self).view)
        let type:NSInteger = (self.Mycommenttype?.rawValue)!
        let dict = ["content":textStr,"type":type,"resourcesId":self.resourcesId ?? "0"] as [String : Any]
        BaseSeverHttp.zpsyPost(withPath: Api_commentPublish, withParams:dict ,withSuccessBlock: {[weak self] (result:Any?) in
            MBProgressHUD.hide(for: CTUtility.findViewController(self).view)
            if (self?.successBlock != nil) {
                self?.successBlock!()
            }
        }) { (err:Error?) in
            MBProgressHUD.hide(for: CTUtility.findViewController(self).view)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            MBProgressHUD.showError("请填写信息")
            return false
        }
        
        let str = MyInputField.text!
        senderMessage(textStr: str)
        
        textField.resignFirstResponder()
        textField.text = ""
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text=""
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if IsEdit == false {
            hotremarkShow()
            return false;
        }
        
        if UserModel.shareInstance().isLogin == false {
            let login = LoginVC()
            login.hidesBottomBarWhenPushed = true
            let loginNv = CTUtility.findViewController(self)
            
            loginNv?.navigationController?.pushViewController(login, animated: false)
            return false;
        }
        
        return IsEdit
    }
    
    func hotremarkShow(){
        let remarkvc=HotRemarkVC();
        remarkvc.hidesBottomBarWhenPushed=true
        remarkvc.mycommenttype = self.Mycommenttype
        remarkvc.resourcesId = self.resourcesId
        CTUtility.findViewController(self).navigationController?.pushViewController(remarkvc, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
