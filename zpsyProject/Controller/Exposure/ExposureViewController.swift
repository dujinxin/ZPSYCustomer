//
//  ExposureViewController.swift
//  ZPSY
//
//  Created by 杜进新 on 2017/9/21.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ExposureViewController: ZPTableViewController {

    var vm = FindListVM()
    var newsType : Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.tableView.estimatedRowHeight = 10
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = 124 + 10 * 2
        //self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)]
        self.tableView.register(FindCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.tableFooterView = UIView()
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.pageCount = 1
            self.request(with: self.pageCount)
        })
        self.tableView.mj_footer = MJRefreshBackFooter(refreshingBlock: { 
            self.pageCount += 1
            self.request(with: self.pageCount)
        })

        self.tableView.mj_header.beginRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FindCell

        cell.mycommentType = "1";
        cell.entity = self.vm.dataArray[indexPath.row] as? FindEntity

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let entity = self.vm.dataArray[indexPath.row] as? FindEntity
        let vc = ExposureDetailVC()
        vc.urlStr = entity?.jumpUrl
        vc.thatID = entity?.ID
        vc.webtype = entity?.field3
        vc.detilStr = entity?.detail
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func request(with page: Int) {
        self.showMBProgressHUD()
        self.vm.loadData(url: ApiString.exposureList.rawValue, param: ["pageNo":page,"newsType":self.newsType]) { (data, msg, isSuccess) in
            self.hideMBProgressHUD()
            self.tableView.mj_footer.endRefreshing()
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
            if isSuccess {
                //self.tableView.reloadData()
            }else{
                
            }
        }
    }
}
