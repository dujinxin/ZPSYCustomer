//
//  feedbackListVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/20.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class feedbackListVC: UITableViewController {

    private var listArr : NSMutableArray? = NSMutableArray.init()
    private var pageNo : NSInteger = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="反馈"
        
        self.tableView.register(FdbackAndReportShowPicCell.self, forCellReuseIdentifier: "ShowPicreuseIdentifier")
        self.tableView.register(FdbackAndReportCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.estimatedRowHeight=10
        self.tableView.rowHeight=UITableViewAutomaticDimension
        self.tableView.sectionHeaderHeight=5
        self.tableView.sectionFooterHeight=5
        self.tableView.contentInset=UIEdgeInsetsMake(-20, 0, 0, 0)
        self.tableView.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: { 
            self.pageNo+=1
            self.datarequest()
        })
        datarequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func datarequest() {
        MBProgressHUD.showAnimationtoView(self.view)
        BaseSeverHttp.zpsyGet(withPath: Api_getFeedBackList, withParams: ["pageNo":pageNo], withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: self.view)
            if self.pageNo == 0{
                self.listArr = NSMutableArray.init(array: feedbackModel.mj_objectArray(withKeyValuesArray: result))
            }else{
                let arr:Array = feedbackModel.mj_objectArray(withKeyValuesArray: result) as Array
                self.listArr?.addObjects(from: arr)
            }
            
            self.tableView.reloadData()
            
        }) { (err:Error?) in
            MBProgressHUD.hide(for: self.view)
        }
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (listArr?.count)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let model:feedbackModel = listArr?[section] as! feedbackModel
        return 1 + model.answerRowGet()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model:feedbackModel = listArr?[indexPath.section] as! feedbackModel
        var isHasPic=true
        let arr = model.imageArrGet()
        if indexPath.row==0 {
            if arr.count == 0 {
                isHasPic=false
            }
              //是否包含图片
            if isHasPic {
                let cell:FdbackAndReportShowPicCell = tableView.dequeueReusableCell(withIdentifier: "ShowPicreuseIdentifier", for: indexPath) as! FdbackAndReportShowPicCell;
                cell.titleLab.text="反馈内容"
                //cell.timelab.text="2010-2-09"
                cell.mainlab.text=model.question
                cell.picShowView.imageUrlArray = NSMutableArray.init(array: arr)
                return cell
            }else{
                let cell:FdbackAndReportCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FdbackAndReportCell;
                cell.titleLab.text="反馈内容"
                //cell.timelab.text="2010-2-09"
                cell.mainlab.text=model.question
                return cell
            }
        }
        else{
            let cell:FdbackAndReportCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FdbackAndReportCell;
            cell.titleLab.text="答复"
            cell.timelab.text=CTUtility.string(from: model.atime, sourceformat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
            cell.mainlab.text=model.answer
            return cell
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
