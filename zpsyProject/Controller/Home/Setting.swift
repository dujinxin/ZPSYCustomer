//
//  Setting.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/9.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class Setting: UITableViewController {
    
    private let listArr=[["意见反馈","关于我们","协议声明","版本信息"],
                         ["商家合作","联系客服     QQ:3558634820"]];
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="设置"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier:"reuseIdentifier")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return listArr.count;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr[section].count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath);
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        
        cell.textLabel?.textColor = JX333333Color
        cell.textLabel?.text = listArr[indexPath.section][indexPath.row];
        
        if indexPath.section == 0 && indexPath.row == 3 {
            cell.accessoryType=UITableViewCellAccessoryType.none;
            
            let detail = UILabel()
            detail.frame = CGRect(x: kScreenWidth - 80 - 20, y: 0, width: 80, height: 44)
            detail.text = kVersion
            detail.textColor = JX333333Color
            detail.textAlignment = .right
            cell.contentView.addSubview(detail)
            
        }else{
            cell.accessoryType=UITableViewCellAccessoryType.disclosureIndicator;
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section==0 {
            if indexPath.row==0 {
                let feedback = FeedbackVC.init(style: UITableViewStyle.grouped)
                self.navigationController?.pushViewController(feedback, animated: true)
            }else if indexPath.row==1{//关于我们
                let webvc = WKwebVC.init()
                webvc.urLstr = HtmlBasUrl + "aboutUs"
                self.navigationController?.pushViewController(webvc, animated: true)
            }else if indexPath.row==2{//协议声明
                let webvc = WKwebVC.init()
                webvc.urLstr = HtmlBasUrl + "agreement"
                self.navigationController?.pushViewController(webvc, animated: true)
            }
            
        }else if indexPath.section==1{
            if indexPath.row==0{//商家合作
                let webvc = WKwebVC.init()
                webvc.urLstr = HtmlBasUrl + "cooperation"
                self.navigationController?.pushViewController(webvc, animated: true)
            }else if indexPath.row==1{//联系我们
            
            }
        }
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
