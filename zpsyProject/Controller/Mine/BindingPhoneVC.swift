//
//  bindingPhoneVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/3/31.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class BindingPhoneVC: UIViewController {

    
    private lazy var phonetextField:UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "输入手机号"
        txtField.leftViewMode = UITextFieldViewMode.always
        txtField.leftView = self.labGet("账    号")
        return txtField
    }()
    
    private lazy var checkTextField:UITextField = {
        let txtField = UITextField()
//        txtField.placeholder = "验证码"
        txtField.leftViewMode = UITextFieldViewMode.always
        txtField.leftView = self.labGet("验证码")
        txtField.rightView = self.checkCodeTimer
        txtField.rightViewMode = UITextFieldViewMode.always
        return txtField
    }()
    
    private lazy var checkCodeTimer:UILabel = {
    
        let lab = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 30))
        lab.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textAlignment = NSTextAlignment.center
        lab.text = "立即获取"
        lab.textColor = UIColor.gray
        
        lab.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.checkCodeBtnClickEvent))
        lab.addGestureRecognizer(tap)
        return lab
    }()
    
    private lazy var submitBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("提交", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.layer.cornerRadius = 3
        btn.layer.masksToBounds = true
        btn.backgroundColor = JXMainColor
        btn.addTarget(self, action: #selector(self.submitBtnClickEvent), for: UIControlEvents.touchUpInside)
        return btn
    }()
    @objc private func checkCodeBtnClickEvent(){
        
        if !CTUtility.isValidateMobile(self.phonetextField.text) {
            MBProgressHUD.showSuccess("请输入正确的手机号")
            return
        }
        startTime()
        let dict:NSDictionary = ["mobile":self.phonetextField.text ?? "" ,"type":"2"]
        MBProgressHUD.showAnimationtoView(self.view)
        BaseSeverHttp.zpsyGet(withPath: Api_getAuthorizationCode, withParams:dict , withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: self.view)
            MBProgressHUD.showSuccess("短信已发送")
        }) { (err:Error?) in
            MBProgressHUD.hide(for: self.view)
        }
    }
    
    @objc private func submitBtnClickEvent(){
        if !CTUtility.isValidateMobile(self.phonetextField.text) {
            MBProgressHUD.showSuccess("请输入正确的手机号")
            return
        }
        if self.checkTextField.text == "" {
            MBProgressHUD.showSuccess("请输入验证码")
            return
        }
        
        MBProgressHUD.showAnimationtoView(self.view)
        BaseSeverHttp.zpsyPost(withPath: Api_bindMobile, withParams: ["mobile":self.phonetextField.text,"password":self.checkTextField.text], withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: self.view)
            MBProgressHUD.showSuccess("绑定成功")
        }) { (err:Error?) in
            MBProgressHUD.hide(for: self.view)
        }
    }

    
//    private func elementListen(){
//        self.phonetextField.rac_textSignal().subscribeNext { (text:Any?) in
//            let phoneStr:String = text as! String
//            if CTUtility.isValidateMobile(phoneStr) {
//                
//                BaseSeverHttp.zpsyGet(withPath: Api_mobileIsExist, withParams: ["mobile":phoneStr], withSuccessBlock: { (result:Any?) in
//                    self.checkCodeTimer.isUserInteractionEnabled = true
//                }, withFailurBlock: { (err:Error?) in
//                    self.checkCodeTimer.isUserInteractionEnabled = false
//                })
//                
//            }else{
//                self.checkTextField.text = ""
//                self.checkCodeTimer.isUserInteractionEnabled = false
//            }
//        }
//        
//       self.checkTextField.rac_textSignal().subscribeNext { (text:Any?) in
//            let checkStr:String = text as! String
//            if checkStr.characters.count > 1{
//                self.submitBtn.isEnabled = true
//            }else{
//                self.submitBtn.isEnabled = false
//            }
//        }
//        
//        
//    }
    
    
    private func startTime(){
        var timeout: Int = 60
        let queue = DispatchQueue.global()
        let source = DispatchSource.makeTimerSource(flags: [], queue: queue)
        source.scheduleRepeating(deadline: .now(), interval: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.milliseconds(100))
        source.setEventHandler{
            if timeout <= 0 {
                source.cancel()
                DispatchQueue.main.async {
                    // 执行操作，例如更新倒计时按钮UI
                    self.checkCodeTimer.isUserInteractionEnabled = true
                    self.checkCodeTimer.text = "立即获取"
                }
            } else {
                DispatchQueue.main.async {
                    // 执行操作，例如更新倒计时按钮UI
                    self.checkCodeTimer.isUserInteractionEnabled = false
                    self.checkCodeTimer.text = "\(timeout)"
                }
            }
            timeout -= 1
        }
        source.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "账号"
        self.view.backgroundColor = UIColor.white
        viewinit()
//        elementListen()
        
    }
    
    private func labGet(_ str : String) -> UILabel {
        
        let lab = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 54))
        lab.font = UIFont.systemFont(ofSize: 17)
        lab.text = str
        lab.textColor = UIColor.black
        return lab
        
    }
    
    
    private func viewinit() {
        let bgView = UIView()
        let lineView = UIView()
        
        bgView.backgroundColor = UIColor.white
        lineView.backgroundColor = UIColor.groupTableViewBackground
        
        self.view.addSubview(bgView)
        bgView.addSubview(self.phonetextField)
        bgView.addSubview(self.checkTextField)
        bgView.addSubview(lineView)
        self.view.addSubview(self.submitBtn)
        
        bgView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.view.mas_left)?.offset()(0)
            let _ = make?.right.mas_equalTo()(self.view.mas_right)?.offset()(0)
            let _ = make?.top.mas_equalTo()(self.view.mas_top)?.offset()(64)
        }
        
        self.phonetextField.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(bgView.mas_left)?.offset()(15)
            let _ = make?.right.mas_equalTo()(bgView.mas_right)?.offset()(-15)
            let _ = make?.top.mas_equalTo()(bgView.mas_top)
            let _ = make?.height.equalTo()(53)
        }
        
        lineView.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(bgView.mas_left)?.offset()(15)
            let _ = make?.right.mas_equalTo()(bgView.mas_right)?.offset()(-15)
            let _ = make?.top.mas_equalTo()(self.phonetextField.mas_bottom)
            let _ = make?.height.equalTo()(1)
        }
        self.checkTextField.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(bgView.mas_left)?.offset()(15)
            let _ = make?.right.mas_equalTo()(bgView.mas_right)?.offset()(-15)
            let _ = make?.top.mas_equalTo()(lineView.mas_bottom)
            let _ = make?.bottom.mas_equalTo()(bgView.mas_bottom)
            let _ = make?.height.equalTo()(53)
        }
        
        self.submitBtn.mas_makeConstraints { (make:MASConstraintMaker?) in
            
            let _ = make?.left.mas_equalTo()(self.view.mas_left)?.offset()(60)
            let _ = make?.right.mas_equalTo()(self.view.mas_right)?.offset()(-60)
            let _ = make?.top.mas_equalTo()(bgView.mas_bottom)?.offset()(120)
            let _ = make?.height.equalTo()(35)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
