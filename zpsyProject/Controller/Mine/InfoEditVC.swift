//
//  InfoEditVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/23.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class InfoEditVC: UIViewController {

    public lazy var headPortrait:UIImageView={
    
        let image=UIImageView.init(image: UIImage.init(named: PlaceHoldeImageStr))
        return image
    }()
    
    public lazy var editText:UITextField={
    
        let textfield=UITextField.init()
        textfield.clearButtonMode=UITextFieldViewMode.always
        return textfield
    }()
    
    private lazy var rightBtn:UIButton={
    
        let but=UIButton(frame:CGRect.init(x: 0, y: 0, width: 40, height: 40))
        but.contentMode=UIViewContentMode.right
        but.setTitleColor(UIColor.white, for: UIControlState.normal)
        but.titleLabel?.font=UIFont.systemFont(ofSize: 14)
        return but
        
    }()
    
    public var editType:NSInteger = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        viewinit()
        rightbtninit()
    }

    private func viewinit() {
        
        if editType==0 {
            self.rightBtn.setTitle("更换", for: UIControlState.normal)
            self.rightBtn.tag=1
            self.view.addSubview(self.headPortrait)
            self.headPortrait.mas_makeConstraints({ (make:MASConstraintMaker?) in
                let _ = make?.edges.mas_equalTo()(UIEdgeInsetsMake(0, 0, 0, 0))
            })
            
            self.headPortrait.sd_setImage(with: URL.init(string: UserModel.shareInstance().userInfo.avatar))
            headPortrait.contentMode=UIViewContentMode.scaleAspectFit
        }else {
            self.rightBtn.setTitle("保存", for: UIControlState.normal)
            if editType==1 {
                self.editText.text=UserModel.shareInstance().userInfo.nickName
            }
            else if editType==2 {
                self.editText.text=UserModel.shareInstance().userInfo.genuid
            }
            
            let view=UIView()
            view.layer.borderWidth=1
            view.layer.borderColor=UIColor.groupTableViewBackground.cgColor
            view.backgroundColor=UIColor.white
            self.view.addSubview(view)
            view.addSubview(editText)
            editText.becomeFirstResponder()
            view.mas_makeConstraints({ (make:MASConstraintMaker?) in
                let _ = make?.left.mas_equalTo()(self.view.mas_left)?.with().offset()(-1)
                let _ = make?.top.mas_equalTo()(self.view.mas_top)?.with().offset()(79)
                let _ = make?.right.mas_equalTo()(self.view.mas_right)?.with().offset()(1)
                let _ = make?.height.equalTo()(40)
            })
            self.editText.mas_makeConstraints({ (make:MASConstraintMaker?) in
                let _ = make?.edges.equalTo()(UIEdgeInsetsMake(0, 16, 0, 16))
            })
            
        
        }
    }


    private func rightbtninit(){
        let rightBar = UIBarButtonItem.init(customView: self.rightBtn)
        self.navigationItem.rightBarButtonItem=rightBar
        self.rightBtn.addTarget(self, action: #selector(rightBtnClcikEvent), for: UIControlEvents.touchUpInside)
    }
    
    @objc private func rightBtnClcikEvent() {
        if self.rightBtn.tag == 1 && editType==0{//编辑
            let picVC:TZImagePickerController=TZImagePickerController.init(maxImagesCount: 1, delegate: nil)
            picVC.didFinishPickingPhotosHandle={[weak self] (photos:[UIImage]?,assets:Any,isSelectOriginalPhoto:Bool)->Void in
                picVC.dismiss(animated: false, completion: nil)
                let clipVC=KevenClipImgControl()
                clipVC.imgArray=NSMutableArray.init(array: photos!)
                clipVC.clipType=MySQUARECLIP
                clipVC.getEditedImageArray={[weak self] (arr:NSMutableArray?)->Void in
                    self?.rightBtn.tag=2
                    self?.headPortrait.image = arr?[0]as? UIImage
                    self?.rightBtn.setTitle("保存", for: UIControlState.normal)
                }
                self?.navigationController?.pushViewController(clipVC, animated: false)
            }
            self.present(picVC, animated: true, completion: nil)
            
        }else{//保存
            saveUserInfo()
        }
    }
    
    //保存
    private func saveUserInfo() {
        
        let dict = NSMutableDictionary.init()
        
        if editType==0 {//头像
            MBProgressHUD.showAnimationtoView(self.view)
            UploadImageTool.uploadImage(self.headPortrait.image, progress: nil, success: {[weak self] (imgStr:String?) in
                MBProgressHUD.hide(for: self?.view)
                dict.setValue(self?.editText.text, forKey: "nickname")
                dict.setValue(imgStr, forKey: "avater")
                self?.dataUpdateRequest(dict: dict)
            }, failure: { 
                MBProgressHUD.hide(for: self.view)
            })
        }else if editType==1 {//昵称
            dict.setValue(self.editText.text, forKey: "nickname")
            dict.setValue(UserModel.shareInstance().userInfo.avatar, forKey: "avater")
            self.dataUpdateRequest(dict: dict)
        }else if editType==2 {//正品号
            
        }
        
    }
    
    private func dataUpdateRequest(dict:NSDictionary){
        MBProgressHUD.showAnimationtoView(self.view)
        BaseSeverHttp.zpsyPost(withPath: Api_userUpdate, withParams: dict, withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: self.view)
            UserModel.shareInstance().userInfo.avatar = dict.object(forKey: "avater") as! String!
            UserModel.shareInstance().userInfo.nickName = dict.object(forKey: "nickname") as! String!
           let _ = self.navigationController?.popViewController(animated: true)
        }) { (err:Error?) in
            MBProgressHUD.hide(for: self.view)
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
