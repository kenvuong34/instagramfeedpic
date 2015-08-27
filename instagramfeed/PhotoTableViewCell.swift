//
//  PhotoTableViewCell.swift
//  instagramfeed
//
//  Created by Zet on 8/27/15.
//  Copyright (c) 2015 platform5. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
