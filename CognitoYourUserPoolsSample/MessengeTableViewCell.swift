//
//  TableViewCell.swift
//  CognitoYourUserPoolsSample
//
//  Created by 何幸宇 on 11/2/17.
//  Copyright © 2017 Dubal, Rohan. All rights reserved.
//

import UIKit

class MessengeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeSent:UILabel!
    @IBOutlet weak var textDisplay: UILabel!
    
    func updateCell(text:String,time:String) {
        timeSent.text = time
        textDisplay.text = text
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
