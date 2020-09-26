//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Anand Sai Mishra on 9/26/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    @IBOutlet var ProfileImageView: UIImageView!
    @IBOutlet var ProfileName: UILabel!
    @IBOutlet var TweetContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
