//
//  ViewController.swift
//  webcrawler
//
//  Created by 江培瑋 on 2018/12/11.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

struct  data_struct{
    var date_d:String = ""
    var buy:String = ""
    var change_limit_buy:String = ""
    var sell:String = ""
    var change_limit_sell:String = ""
}
class ViewController: UIViewController {

    @IBOutlet weak var tableview_gold: UITableView!
    var gold_array:[data_struct] = Array()
    var check:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        load_data()
        
      
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension ViewController{
    func load_data() {

        Alamofire.request("https://www.goldlegend.com/tw/price").responseString { response in
            if let html = response.result.value{
                self.parsehtml(html)
            }
        }
    }
    func parsehtml(_ html1:String)  {
        var gg:NSString = " "
        var  doc = try? Kanna.HTML(html: html1, encoding: String.Encoding.utf8)
        var s = data_struct()
        for i in 1...10{
            for j in 1...5{
                for rate in doc!.xpath("//*[@id=\"priceTable\"]/tbody/tr[\(i)]/td[\(j)]") {

                    if (j == 1){

                        gg = rate.text! as NSString
                        s.date_d = gg.replacingOccurrences(of: " ", with: "")
                    }
                    if (j == 2){
                        gg = rate.text! as NSString
                        s.buy = gg as String
                    }
                    if (j == 3){
                        gg = rate.text! as NSString
                        s.change_limit_buy = gg as String
                    }
                    if (j == 4){
                        gg = rate.text! as NSString
                        s.sell = gg as String
                    }
                    if (j == 5){
                        gg = rate.text! as NSString
                        s.change_limit_sell = gg as String
                    }
                }
            }
            gold_array.append(s)

        }
        tableview_gold.reloadData()

    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  gold_array.count > 0 {
            return gold_array.count
        }else{
               return 0
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goldtableview", for: indexPath) as! TableViewCell

        cell.lab_date.adjustsFontSizeToFitWidth = true
        cell.lab_date.text = "\(gold_array[indexPath.row].date_d)"
        
        print("\(gold_array[indexPath.row].date_d)")
        cell.lab_buy.text = gold_array[indexPath.row].buy
        cell.lab_change_limit_buy.text = gold_array[indexPath.row].change_limit_buy
        cell.lab_sell.text = gold_array[indexPath.row].sell
        cell.lab_change_limit_sell.text = gold_array[indexPath.row].change_limit_sell
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let cell = tableView.dequeueReusableCell(withIdentifier: "goldtableview") as! TableViewCell
        cell.lab_date.text = "日期"
        cell.lab_buy.text = "買進"
        cell.lab_change_limit_buy.text = "漲跌"
        cell.lab_sell.text = "賣出"
        cell.lab_change_limit_sell.text = "漲跌"
        cell.backgroundColor = UIColor.gray
                
        cell.lab_date.textColor = UIColor.white
        cell.lab_buy.textColor = UIColor.white
        cell.lab_change_limit_buy.textColor = UIColor.white
        cell.lab_sell.textColor = UIColor.white
        cell.lab_change_limit_sell.textColor = UIColor.white
                
        cell.lab_date.font = cell.lab_date.font.withSize(20)
        cell.lab_buy.font = cell.lab_buy.font.withSize(20)
        cell.lab_change_limit_buy.font = cell.lab_change_limit_buy.font.withSize(20)
        cell.lab_sell.font = cell.lab_sell.font.withSize(20)
        cell.lab_change_limit_sell.font = cell.lab_change_limit_sell.font.withSize(20)
        
        headerView.addSubview(cell)
        return headerView
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
}

