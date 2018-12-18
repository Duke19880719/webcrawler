//
//  TableViewCell.swift
//  webcrawler
//
//  Created by 江培瑋 on 2018/12/17.
//  Copyright © 2018年 江培瑋. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lab_date: UILabel!
    @IBOutlet weak var lab_buy: UILabel!
    @IBOutlet weak var lab_change_limit_buy: UILabel!
    @IBOutlet weak var lab_sell: UILabel!
    @IBOutlet weak var lab_change_limit_sell: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
