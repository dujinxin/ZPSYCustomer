//
//  UserInfoEditVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/22.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class UserInfoEditVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="基本信息"
        self.tableView.isEditing=false
        self.tableView.isScrollEnabled=false
        self.tableView.sectionHeaderHeight=1
        self.tableView.sectionFooterHeight=14
        self.tableView.contentInset=UIEdgeInsets.init(top: -15, left: 0, bottom: 0, right: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 1;
        }
        return 2
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0{
            return 80
        }
        return 45
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section==0 {
            let cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "reuseIdentifier")
            cell.selectionStyle=UITableViewCellSelectionStyle.none
            let imageView=UIImageView.init(image: UIImage.init(named: "scoreBg"))
            imageView.frame=CGRect.init(x: 15, y: 5, width: 70, height: 70)
            imageView.layer.cornerRadius=35
            imageView.layer.masksToBounds=true
            imageView.contentMode=UIViewContentMode.scaleAspectFill
            if let avatar = UserManager.manager.userEntity.avatar {
                imageView.sd_setImage(with: URL(string: avatar), placeholderImage: UIImage(named: PlaceHoldeImageStr))
            }
            
            cell.contentView.addSubview(imageView)
            let  lab = getlable(nameStr: "上传头像")
            lab.textColor=UIColor.black
            lab.frame=CGRect.init(x: 95, y: 0, width: 100, height: 80)
            cell.contentView.addSubview(lab)
            return cell
        }else{
            var cell:UITableViewCell?
            if indexPath.row==0 {
                cell = getCell(titleStr: "昵称：", detailStr: UserManager.manager.userEntity.nickName)
            }
            else{
                cell = getCell(titleStr: "账号：", detailStr: UserManager.manager.userEntity.mobile)
            }
            return cell!
        }
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var editType = 0
        var editTitle:String = ""
        if indexPath.section == 0 {
            editType = 0       //头像
            editTitle = "头像"
        }else{
            if indexPath.row == 0 {
                editType = 1   //昵称
                editTitle = "昵称"
            }else{
                if UserManager.manager.userEntity.mobile.isEmpty == true {
                    let bindingVc = BindingPhoneVC()
                    self.navigationController?.pushViewController(bindingVc, animated: true)
                    return
                }
            }
        }
        
        let editvc = InfoEditVC()
        editvc.editType = editType
        editvc.title = editTitle
        self.navigationController?.pushViewController(editvc, animated: true)
    }
    
    
    func getCell(titleStr:String,detailStr:String) -> UITableViewCell  {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "nameAndNumreuseIdentifier")
        cell.selectionStyle=UITableViewCellSelectionStyle.none
        let TitleLab = getlable(nameStr: titleStr)
        TitleLab.tag = 10
        TitleLab.textColor = UIColor.black
        cell.contentView.addSubview(TitleLab)
        TitleLab.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(cell.contentView.mas_left)?.with().offset()(15)
            let _ = make?.centerY.equalTo()(cell.contentView)
        })
        
        let detaiLab = getlable(nameStr: detailStr)
        detaiLab.tag = 11
        cell.contentView.addSubview(detaiLab)
        detaiLab.mas_makeConstraints({ (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(TitleLab.mas_right)?.with().offset()(0)
            let _ = make?.centerY.equalTo()(cell.contentView)
        })

        return cell
    }

    
    
    func getlable(nameStr:String) -> UILabel {
        let detaiLab = UILabel()
        detaiLab.font=UIFont.systemFont(ofSize: 15)
        detaiLab.text=nameStr
        detaiLab.textColor=UIColor.gray
        return detaiLab
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
