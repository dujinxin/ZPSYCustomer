//
//  ProductDetailVC.swift
//  ZPSY
//
//  Created by zhouhao on 2017/2/24.
//  Copyright © 2017年 zhouhao. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    public var ProductID:String?
    
    private var productdetailModel:productDetailModel? = productDetailModel()
    
    private lazy var collectionNumLab:UILabel={
        let lab = UILabel()
        lab.textColor = Utility.color(withHex: 0x333333)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.text = "0" + "人收藏了该产品"
        return lab
    }()
    
    private lazy var CycleScroll:SDCycleScrollView={
        let cyclescroll=SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 242*kScaleOfScreen), delegate: nil, placeholderImage: UIImage.init(named: PlaceHoldeImageStr))
        cyclescroll?.imageURLStringsGroup = []
        cyclescroll?.autoScroll = false
        cyclescroll?.pageControlAliment=SDCycleScrollViewPageContolAlimentCenter
        return cyclescroll!
    }()
    
    
    private lazy var tableView:UITableView={
    
        let tab=UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-60-64), style: UITableViewStyle.grouped)
        tab.tableHeaderView=self.CycleScroll
        tab.rowHeight=UITableViewAutomaticDimension
        tab.estimatedRowHeight=10
        tab.sectionHeaderHeight=UITableViewAutomaticDimension
        tab.sectionFooterHeight=UITableViewAutomaticDimension
        tab.estimatedSectionHeaderHeight=5
        tab.estimatedSectionFooterHeight=5
        tab.separatorStyle = UITableViewCellSeparatorStyle.none
        tab.delegate=self
        tab.dataSource=self
        tab.register(productDetailCell.self, forCellReuseIdentifier: "productDetailCellId")
        return tab
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="详情"
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        datarequest()
        viewinit()
    }

    func viewinit(){
        self.view.addSubview(self.tableView)
        
        let inputview=CommentInputView.init(false)
        inputview.Mycommenttype = commentType.commentProduct
        inputview.resourcesId = self.ProductID
        self.view.addSubview(inputview)
        inputview.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.view.mas_left);
            let _ = make?.right.mas_equalTo()(self.view.mas_right);
            let _ = make?.bottom.mas_equalTo()(self.view.mas_bottom);
            let _ = make?.top.mas_equalTo()(self.tableView.mas_bottom);
        }
    }
    
    
    private func datarequest(){
        MBProgressHUD.showAnimationtoView(self.view)
        BaseSeverHttp.zpsyGet(withPath: Api_productFindById, withParams: ["id":self.ProductID], withSuccessBlock: { (result:Any?) in
            MBProgressHUD.hide(for: self.view)
            self.productdetailModel = productDetailModel.mj_object(withKeyValues: result)
            self.CycleScroll.imageURLStringsGroup = self.productdetailModel?.getArrGoodsImg() as! [Any]!
            self.collectionNumLab.text = (self.productdetailModel?.favoritesNum)! + "人收藏了该产品"
            self.tableView.reloadData()
        }) { (err:Error?) in
            MBProgressHUD.hide(for: self.view)
        }
    }
    
        // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return 1
        }
        
       return (self.productdetailModel?.list_ceccGoodsField?.count)!
        
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
            if cell==nil{
                cell=UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "reuseIdentifier")
                cell?.selectionStyle=UITableViewCellSelectionStyle.none
                let img = UIImageView.init(image: UIImage.init(named: "collect"))
                img.size = CGSize.init(width: 30, height: 30)
                cell?.accessoryView=img
                img.isUserInteractionEnabled = true
                img.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.collectionBtnClick(gest:))))
            }
            cell?.textLabel?.textColor = Utility.color(withHex: 0x333333)
            cell?.textLabel?.text = self.productdetailModel?.value(forKey: "name") as! String?
            let img:UIImageView = cell?.accessoryView as! UIImageView
            if self.productdetailModel?.isFavorites == "0" {
                img.image = UIImage.init(named: "collectSuccess")
            }else{
                img.image = UIImage.init(named: "collect")
            }
            return cell!
        }
        else{
            let cell:productDetailCell = tableView.dequeueReusableCell(withIdentifier: "productDetailCellId") as! productDetailCell
            let dict:NSDictionary = self.productdetailModel?.list_ceccGoodsField![indexPath.row] as! NSDictionary
            let titleStr:String = dict.object(forKey: "fieldName")as! String
            let keyStr:String = dict.object(forKey: "fieldValue")as! String
            cell.nameLabel.text = titleStr + " : " + keyStr
           return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            return headerget()
        }
        return nil
    }
    
    private var hasthread:Bool? = false

    @objc private func collectionBtnClick(gest : UIGestureRecognizer){
        
        if hasthread! {
            return;
        }
        
        if !UserModel.shareInstance().isLogin {
            let login = LoginVC()
            self.present(login, animated: true, completion: nil)
            return
        }
        
        self.hasthread = true
        
        let img:UIImageView = gest.view as! UIImageView
        
        var flag = "0"
        if self.productdetailModel?.isFavorites == "1" {
            flag = "0"
            img.image = UIImage.init(named: "collectSuccess")
        }else{
            flag = "1"
            img.image = UIImage.init(named: "collect")
        }
        self.productdetailModel?.isFavorites = flag
        BaseSeverHttp.zpsyGet(withPath: Api_userFavorites, withParams: ["resourceId":self.ProductID,"flag":flag,"type":"0"], withSuccessBlock: { (result:Any?) in
            self.hasthread = false
            var num:NSInteger = NSInteger.init((self.productdetailModel?.getProperty(key: "favoritesNum"))!)!
            if self.productdetailModel?.isFavorites == "0"  {
                num+=1
            }else{
                num-=1
            }
            
            self.productdetailModel?.favoritesNum = String.init(num)
            self.collectionNumLab.text = (self.productdetailModel?.favoritesNum)! + "人收藏了该产品"
        }) { (err:Error?) in
            self.hasthread = false
        }
    }
    
    private func headerget() -> UIView {
        let view = getlineview(0xffffff)
        let lineOne = getlineview(0xcccccc)
        let lineTwo = getlineview(0xcccccc)
        let lineThird = getlineview(0x333333)
        
        let lab = UILabel()
        lab.textColor = Utility.color(withHex: 0x333333)
        lab.text = "产品基本信息"
        lab.font = UIFont.systemFont(ofSize: 13)
        
        view.addSubview(self.collectionNumLab)
        view.addSubview(lineOne)
        view.addSubview(lineTwo)
        view.addSubview(lineThird)
        view.addSubview(lab)
        
        self.collectionNumLab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.top.mas_equalTo()(view.mas_top)?.offset()(10)
            let _ = make?.centerX.mas_equalTo()(view)
        }
        lineOne.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.right.mas_equalTo()(self.collectionNumLab.mas_left)?.offset()(-20)
            let _ = make?.centerY.mas_equalTo()(self.collectionNumLab)
            let _ = make?.size.equalTo()(CGSize.init(width: 60, height: 1))
        }
        lineTwo.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(self.collectionNumLab.mas_right)?.offset()(20)
            let _ = make?.centerY.mas_equalTo()(self.collectionNumLab)
            let _ = make?.size.equalTo()(CGSize.init(width: 60, height: 1))
        }

        lineThird.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(view.mas_left)?.offset()(15)
            let _ = make?.top.mas_equalTo()(self.collectionNumLab.mas_bottom)?.offset()(15)
            let _ = make?.bottom.mas_equalTo()(view.mas_bottom)?.offset()(-15)
            let _ = make?.size.equalTo()(CGSize.init(width: 4, height: 14))
        }
        
        lab.mas_makeConstraints { (make:MASConstraintMaker?) in
            let _ = make?.left.mas_equalTo()(lineThird.mas_right)?.offset()(5)
            let _ = make?.centerY.mas_equalTo()(lineThird)
        }
        
        return view
    }
    func getlineview(_ colorHex:NSInteger) -> UIView {
        let view = UIView()
        view.backgroundColor = Utility.color(withHex: colorHex)
        return view
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.1
        }
        return UITableViewAutomaticDimension
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
