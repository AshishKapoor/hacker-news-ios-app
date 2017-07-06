//
//  HNStoriesTVC.swift
//  Hacker News
//
//  Created by Ashish Kapoor on 04/07/17.
//  Copyright © 2017 swiftobjc@gmail.com All rights reserved.
//

import UIKit
import Skeleton

class HNStoriesTVC: UITableViewCell {
    @IBOutlet weak var imagePlaceholderView: UIView!
    @IBOutlet weak var titlePlaceholderView: GradientContainerView!
    @IBOutlet weak var subtitlePlaceholderView: GradientContainerView!
    
    @IBOutlet weak var storyTitle: UILabel!
    @IBOutlet weak var storySubTitle: UILabel!
    @IBOutlet weak var scoreTitle: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        imagePlaceholderView.layer.cornerRadius     = 5
        imagePlaceholderView.layer.borderWidth      = 3
        imagePlaceholderView.layer.borderColor      = UIColor.orange.cgColor
    }
}

extension HNStoriesTVC: GradientsOwner {
    var gradientLayers: [CAGradientLayer] {
        return [titlePlaceholderView.gradientLayer, subtitlePlaceholderView.gradientLayer]
    }
}
