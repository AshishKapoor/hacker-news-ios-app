//
//  HNStoryDetailTVCell.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 09/07/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HNStoryDetailTVCell: UITableViewCell {

    @IBOutlet weak var googleBannerAd: GADBannerView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
